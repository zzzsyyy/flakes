{ config, lib, ... }:

let
  cfg = config.networking.clash;
in

{
  imports = [
    ./clash
    # ./wireguard.nix
  ];

  networking = {
    hostName = "zzzsy";
    useDHCP = false;
    firewall.enable = false;
    networkmanager.enable = true;

    clash = {
      enable = true;
      mixinConfig = {
        port = 7891;
        socks-port = 7892;
        mixed-port = 7890;
        log-level = "info";
        external-controller = "127.0.0.1:7900";
      };
      auto-update = {
        enable = true;
        service = "main";
      };
    };
  };
  systemd.services.nix-daemon.environment = cfg.environment;
}

