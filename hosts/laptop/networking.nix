{
  programs.clash-verge = {
    enable = true;
  };
  networking = {
    useDHCP = false;
    firewall.enable = false;
    networkmanager.enable = true;
  };
  services.daet = {
    enable = true; # @TODO
    configFile = ./yc.dae;
  };
}

