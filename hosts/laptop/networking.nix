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
    enable = true; # @TODO
    configFile = ./min.dae;
  };
  services.sing-box = {
    enable = false;
  };
}

