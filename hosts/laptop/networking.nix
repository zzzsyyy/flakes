{ lib
, pkgs
, ...
}:

{
  programs.clash-verge = {
    enable = true;
  };
  networking = {
    useDHCP = false;
    firewall.enable = false;
    networkmanager.enable = true;
  };
  services.dae = {
    enable = true;
    config = ./yc.dae;
  };
}

