{
  lib,
  config,
  modulesPath,
  pkgs,
  ...
}:

let
  btrfsSubvol =
    device: subvol: extraConfig:
    lib.mkMerge [
      {
        inherit device;
        fsType = "btrfs";
        options = [
          "subvol=${subvol}"
          "compress=zstd"
          "noatime"
        ];
      }
      extraConfig
    ];
  btrfsSubvolMain = btrfsSubvol "/dev/disk/by-partlabel/NixOS";
in

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.initrd.systemd.enable = true; # for perservation
  boot.kernelModules = [
    "squashfs"
    "kvm-amd"
    "iwlwifi"
  ];

  # for obs virtual camera
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback exclusive_caps=1 video_nr=9 card_label="obs"
    options iwlwifi power_save=0
    options iwlmvm power_scheme=1
  '';

  fileSystems."/" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = [
      "defaults"
      "size=4G"
      "mode=755"
    ];
  };
  fileSystems."/var/log" = btrfsSubvolMain "@log" { };
  fileSystems."/persist" = btrfsSubvolMain "@persist" { neededForBoot = true; };
  fileSystems."/nix" = btrfsSubvolMain "@nix" { neededForBoot = true; };
  fileSystems."/swap" = btrfsSubvolMain "@swap" { };
  fileSystems."/.snapshots" = btrfsSubvolMain "@snapshots" { };
  ##! permission
  ## sudo chmod -R a+rwX,o-rw /home/$USER
  fileSystems."/home" = btrfsSubvolMain "@home" { };
  fileSystems."/boot" = {
    device = "/dev/disk/by-partlabel/BOOT";
    fsType = "vfat";
    options = [ "umask=0077" ];
  };

  swapDevices = [
    {
      device = "/swap/swapfile";
      size = 24 * 1024;
    }
  ];

  #boot.resumeDevice = "/dev/disk/by-partlabel/NixOS";
  #boot.kernelParams = [ "mem_sleep_default=deep" "resume_offset=24927051" ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  services.xserver = {
    videoDrivers = [ "amdgpu" ];
  };
  services.pulseaudio.enable = false;
  hardware = {
    graphics.enable = true;
    graphics.extraPackages = [ pkgs.amf ];
    bluetooth = {
      enable = true;
    };
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = true;
  };
}
