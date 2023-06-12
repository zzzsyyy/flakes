{ config
, lib
, pkgs
, ...
}:

{
  programs.clash-verge = {
    enable = true;
    tunMode = true;
    autoStart = true;
  };

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
}

