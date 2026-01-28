{
  config,
  pkgs,
  lib,
  ...
}:
{
  services = {
    # scx scheduler
    scx.enable = true;
    scx.scheduler = "scx_lavd";

    ucodenix = {
      enable = true;
      cpuModelId = "00A70F52";
    };

    upower.enable = true;

    dbus.implementation = "broker"; # lock dbus impl to dbus-broker
    udev.extraRules = ''
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0666", TAG+="uaccess", TAG+="udev-acl"
      SUBSYSTEM=="usb", ATTR{idVendor}=="04e8", MODE="0666", GROUP="adbusers"
    '';
    fstrim.enable = true;
    openssh = {
      enable = true;
      settings.PermitRootLogin = lib.mkDefault "no";
    };
    speechd.enable = false;
    fwupd.enable = true;
    tuned.enable = true;
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
    earlyoom = {
      enable = true;
    };
    gvfs.enable = true;
    udisks2.enable = true;
    printing = {
      enable = true;
      drivers = with pkgs; [
        cups-filters
        cups-browsed
      ];
      webInterface = true;
    };

    # blueman.enable = true;
  };
}
