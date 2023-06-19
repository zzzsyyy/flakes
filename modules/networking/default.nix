{ config
, lib
, pkgs
, ...
}:

{
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
}

