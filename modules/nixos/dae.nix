{ config
, pkgs
, lib
, ...
}:
let
  cfg = config.services.dae;
in
{
  disabledModules = [ "services/networking/dae.nix" ];
  options = {
    services.dae = with lib;{
      enable = mkEnableOption (mkDoc "A Linux high-performance transparent proxy solution based on eBPF");
      package = mkPackageOption pkgs "dae" { };
      configFile = mkOption {
        type = types.path;
        default = "/etc/dae/config.dae";
        example = "/path/to/your/config.dae";
        description = mdDoc ''
          The path of dae config file, end with `.dae`.

          See <https://github.com/daeuniverse/dae/blob/main/example.dae>
        '';
      };
      disableTxChecksumIpGeneric = mkEnableOption (mkDoc "See https://github.com/daeuniverse/dae/issues/43");
    };
  };

  config = lib.mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 12345 ];
    networking.firewall.allowedUDPPorts = [ 12345 ];
    environment.etc."dae/config.dae" = {
      mode = "0400";
      source = cfg.configFile;
    };


    systemd.services.dae = {
      unitConfig = {
        Description = "dae Service";
        Documentation = "https://github.com/daeuniverse/dae";
        After = [ "network.target" "systemd-sysctl.service" ];
        Wants = [ "network.target" ];
      };

      reloadTriggers = [ config.environment.etc."dae/config.dae".source ];
      serviceConfig = {
        User = "root";
        ExecStartPre = "${lib.getExe cfg.package} validate -c /etc/dae/config.dae";
        ExecStart = "${lib.getExe cfg.package} run --disable-timestamp -c /etc/dae/config.dae";
        ExecReload = "${lib.getExe cfg.package} reload $MAINPID";
        LimitNPROC = 512;
        LimitNOFILE = 1048576;
        Restart = "on-abnormal";
        Type = "notify";
      };

      wantedBy = [ "multi-user.target" ];
    };
  };
}
