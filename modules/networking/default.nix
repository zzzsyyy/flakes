{ config
, lib
, pkgs
, ...
}:

{
  imports = [ ./dae.nix ];
  programs.clash-verge = {
    enable = true;
  };
  #@TODO
  # hysteria
  networking = {
    hostName = "zzzsy";
    useDHCP = false;
    firewall.enable = false;
    networkmanager.enable = true;
    # proxy = {
    #   allProxy = "http://127.0.0.1:7890";
    #   noProxy = "127.0.0.1,localhost,.localdomain";
    # };
  };
  services.dae = {
    enable = true;
    config = ./yc.dae;
  };
}

