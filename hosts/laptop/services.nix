{ config
, ...
}: {
  services = {
    fstrim.enable = true;
    openssh.enable = true;
    printing.enable = true;
    fwupd.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    transmission = {
      enable = true;
      user = "zzzsy";
      group = "users";
      downloadDirPermissions = "755";
      home = "/home/zzzsy";
      settings = {
        download-dir = "${config.services.transmission.home}/Downloads/Transmission";
        incomplete-dir-enabled = false;
      };
    };
    # zerotierone = {
    #   enable = true;
    #   joinNetworks = [ "" ];
    #   port = 9993; #default
    # };
  };
}
