{ config
, lib
, modulesPath
, ...
}:

let
  btrfsSubvol = device: subvol: extraConfig: lib.mkMerge [
    {
      inherit device;
      fsType = "btrfs";
      options = [ "subvol=${subvol}" "compress=zstd" "noatime" ];
    }
    extraConfig
  ];
  #@TODO using by-label
  btrfsSubvolMain = btrfsSubvol "/dev/disk/by-uuid/7143cc39-c607-486f-866d-a703efd5d956";

in

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" "v4l2loopback" ];

  # for obs virtual camera
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  boot.extraModprobeConfig = ''
    options v4l2loopback exclusive_caps=1 video_nr=9 card_label="obs"
  '';

  fileSystems."/" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = [ "defaults" "size=4G" "mode=755" ];
  };
  fileSystems."/var/log" = btrfsSubvolMain "@log" { };
  fileSystems."/persist" = btrfsSubvolMain "@persist" { neededForBoot = true; };
  fileSystems."/nix" = btrfsSubvolMain "@nix" { neededForBoot = true; };
  ##! permission
  ## sudo chmod -R a+rwX,o-rw /home/$USER
  fileSystems."/home" = btrfsSubvolMain "@home" { };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/10CC-BC59";
    fsType = "vfat";
  };


  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
