{ config, lib, pkgs, ... }:
let
  cfg = config.networking.clash;

  scripts = pkgs.stdenvNoCC.mkDerivation rec {
    name = "clash-scripts";
    buildCommand = ''
      install -Dm755 $enableProxy     $out/bin/enable-proxy
      install -Dm755 $disableProxy    $out/bin/disable-proxy
      install -Dm755 $updateClashUrl  $out/bin/update-clash-url
      install -Dm755 $updateClash     $out/bin/update-clash
    '';
    enableProxy = pkgs.substituteAll {
      src = ./enable-proxy;
      mixedPort = cfg.mixinConfig.mixed-port;
    };
    disableProxy = pkgs.substituteAll {
      src = ./disable-proxy;
    };
    updateClashUrl = pkgs.substituteAll {
      src = ./update-clash-url.sh;
      isExecutable = true;
      inherit (pkgs.stdenvNoCC) shell;
      inherit (pkgs) coreutils curl systemd;
      dasel = pkgs.dasel;

      port = cfg.mixinConfig.port;
      socksport = cfg.mixinConfig.socks-port;
      mixedport = cfg.mixinConfig.mixed-port;
      loglevel = cfg.mixinConfig.log-level;
      exct = cfg.mixinConfig.external-controller;

      directory = "/var/lib/clash";
    };
    updateClash = pkgs.substituteAll {
      src = ./update-clash.sh;
      isExecutable = true;
      inherit (pkgs.stdenvNoCC) shell;
      inherit updateClashUrl;
      gUrl = config.sops.secrets."clash/g".path;
      xUrl = config.sops.secrets."clash/x".path;
      yUrl = config.sops.secrets."clash/y".path;
    };
  };
in
with lib;
{
  options.networking.clash = {
    enable = mkOption {
      type = with types; bool;
      default = false;
    };
    mixinConfig = mkOption {
      type = with types; attrs;
    };
    environment = mkOption {
      type = with types; attrsOf str;
      description = ''
        Proxy environment.
      '';
      default =
        let
          proxyUrl = "http://localhost:${toString cfg.mixinConfig.mixed-port}";
        in
        {
          HTTP_PROXY = proxyUrl;
          HTTPS_PROXY = proxyUrl;
          http_proxy = proxyUrl;
          https_proxy = proxyUrl;
        };
    };
    stringEnvironment = mkOption {
      type = with types; listOf str;
      description = ''
        Proxy environment in strings.
      '';
      default = map
        (key:
          let value = lib.getAttr key cfg.environment;
          in "${key}=${value}"
        )
        (lib.attrNames cfg.environment);
    };
    auto-update = {
      enable = mkEnableOption "clash auto-update";
      service = mkOption {
        type = with types; str;
        description = ''
          Service used in auto update.
        '';
      };
    };
  };

  config = mkIf (cfg.enable) (mkMerge [
    {
      systemd.services.clash = {
        description = "A rule based proxy in GO";
        script = ''
          "${pkgs.clash}/bin/clash" -d "$STATE_DIRECTORY"
        '';
        serviceConfig = {
          Type = "exec";
          DynamicUser = true;
          StateDirectory = "clash";
          AmbientCapabilities = [
            "CAP_NET_BIND_SERVICE"
            "CAP_NET_ADMIN"
          ];
        };
        wantedBy = [ "multi-user.target" ];
      };

      sops.secrets."clash/g" = {
        restartUnits = [ "clash-auto-update.service" ];
      };
      sops.secrets."clash/x" = {
        restartUnits = [ "clash-auto-update.service" ];
      };
      sops.secrets."clash/y" = {
        restartUnits = [ "clash-auto-update.service" ];
      };

      environment.systemPackages = [
        scripts
      ];
      security.sudo.extraConfig = ''
        Defaults env_keep += "HTTP_PROXY HTTPS_PROXY FTP_PROXY ALL_PROXY NO_PROXY"
        Defaults env_keep += "http_proxy https_proxy ftp_proxy all_proxy no_proxy"
      '';
    }

    (mkIf cfg.auto-update.enable {
      systemd.services.clash-auto-update = {
        script = ''
          "${scripts}/bin/update-clash" "${cfg.auto-update.service}"
        '';
        serviceConfig = {
          Type = "oneshot";
          Restart = "on-failure";
          RestartSec = 30;
        };
        after = [ "network-online.target" "clash.service" ];
      };
      systemd.timers.clash-auto-update = {
        timerConfig = {
          OnCalendar = "05:00";
        };
        wantedBy = [ "timers.target" ];
      };
    })
  ]);
}
