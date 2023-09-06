{
  networking = {
    useDHCP = false;
    firewall.enable = false;
    networkmanager.enable = true;
  };
  services.dae = {
    enable = true;
    disableTxChecksumIpGeneric = false;
    config = builtins.readFile (./min.dae);
  };
}

