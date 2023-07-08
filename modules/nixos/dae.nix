{ pkgs
, config
, lib
, ...
}:
with lib;
let
  cfg = config.services.dae;
in
{
  options.services.dae = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
    package = mkOption {
      type = types.package;
      default = pkgs.dae;
    };
    config = mkOption {
      type = types.path;
      default = /etc/daeconf.dae;
    };
  };
  config =
    let
      configFile = "/etc/daeconf.dae";
      assets = "${pkgs.my.geos}/share/v2ray";
      dae = lib.getExe cfg.package;
    in
    mkIf cfg.enable {
      environment.etc."daeconf.dae" = {
        mode = "0600";
        source = cfg.config;
      };
      networking.firewall = {
        allowedUDPPorts = [ 12345 ];
        allowedTCPPorts = [ 12345 ];
      };

      systemd.services.dae = {
        reloadTriggers = [ configFile ];
        wantedBy = [ "multi-user.target" ];
        after = [
          "network-online.target"
          "systemd-sysctl.service"
        ];
        wants = [
          "network-online.target"
          "systemd-networkd-wait-online.service"
        ];
        description = "Dae mon";

        serviceConfig = {
          Type = "notify";
          User = "root";
          LimitNPROC = 512;
          LimitNOFILE = 1048576;
          Environment = "DAE_LOCATION_ASSET=${assets}";
          ExecStartPre = [ "${dae} validate -c ${configFile}" ];
          ExecStart = "${dae} run --disable-timestamp -c ${configFile}";
          ExecReload = "${dae} reload $MAINPID";
          Restart = "on-abnormal";
        };
      };
    };
}
