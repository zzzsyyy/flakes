{ config
, pkgs
, ...
}: {
  services = {
    fstrim.enable = true;
    openssh.enable = true;
    printing.enable = true;
    fwupd.enable = true;
    power-profiles-daemon.enable = false;
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        START_CHARGE_THRESH_BAT0 = 85;
        STOP_CHARGE_THRESH_BAT0 = 90;
      };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    transmission = {
      enable = true;
      package = pkgs.transmission_4;
      user = "zzzsy";
      group = "users";
      downloadDirPermissions = "755";
      home = "/home/zzzsy";
      settings = {
        download-dir = "${config.services.transmission.home}/Downloads/Transmission";
        incomplete-dir-enabled = false;
      };
    };
    navidrome = {
      enable = false;
      settings = {
        Address = "192.168.49.43";
        MusicFolder = "/srv/music";
        Port = 4533;
        ScanSchedule = "0";
        EnableStarRating = false;
      };
    };
  };
}
