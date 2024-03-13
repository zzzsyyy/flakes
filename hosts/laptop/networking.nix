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
  services.zerotierone = {
    enable = true;
    joinNetworks = [ "ccc5da5295c853d4" ];
  };
}
