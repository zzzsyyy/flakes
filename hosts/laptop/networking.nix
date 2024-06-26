{ config, pkgs, ... }:
{
  networking = {
    useDHCP = false;
    firewall.enable = false;
    networkmanager.enable = true;
  };
  services.dae = {
    enable = true;
    configFile = "/home/zzzsy/.config/dae/config.dae";
  };
  systemd.services.dae.serviceConfig.StandardOutput = "append:/var/log/dae.log";
  services.daed = {
    enable = false;
    configDir = "/home/zzzsy/.config/daed";
  };
  services.zerotierone = {
    enable = true;
    joinNetworks = [ "0cccb752f79f6de5" ];
  };
}
