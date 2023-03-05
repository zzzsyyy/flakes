{ config
, lib
, pkgs
, ...
}:

{
  imports = [
    # ./wireguard.nix
  ];
  environment.systemPackages = with pkgs;[
    clash-verge
    # clash-meta
  ];

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

