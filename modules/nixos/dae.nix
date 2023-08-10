{ config, pkgs, lib, ... }:
let
  cfg = config.services.daet;
in
{
  meta.maintainers = with lib.maintainers; [ pokon548 ];

  options = {
    services.daet = {
      enable = lib.options.mkEnableOption (lib.mdDoc "the dae service");
      package = lib.mkPackageOptionMD pkgs "dae" { };
      settingsFile = lib.mkOption {
        type = lib.types.path;
        default = "/etc/dae/config.dae";
        example = "/path/to/your/config.dae";
      };
    };
  };

  config = lib.mkIf config.services.daet.enable {
    networking.firewall.allowedTCPPorts = [ 12345 ];
    networking.firewall.allowedUDPPorts = [ 12345 ];
    environment.etc."dae/config.dae" = {
      mode = "0600";
      source = cfg.settingsFile;
    };


    systemd.services.daet = {
      unitConfig = {
        Description = "dae Service";
        Documentation = "https://github.com/daeuniverse/dae";
        After = [ "network.target" "systemd-sysctl.service" ];
        Wants = [ "network.target" ];
      };

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
