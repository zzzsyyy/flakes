{ pkgs
, ...
}:

{
  imports =
    [
      ./gnome
      ./fonts
      ./rime
      ./hardware.nix
      ./services.nix
      ./virt.nix
      ./networking.nix
    ];

  boot = {
    plymouth.enable = true;
    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 5;
      efi.canTouchEfiVariables = false; #@TODO
    };
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    #@TODO
    kernelParams = [
      "amd_pstate=active"
      "pti=on"
      "quiet"
      "log_level=3"
      "nowatchdog"
    ];
    supportedFilesystems = [ "ntfs" ];
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.TERMINAL = [ "kitty" ];


  time.timeZone = "Asia/Shanghai";

  i18n = {
    defaultLocale = "zh_CN.UTF-8";
    supportedLocales = [ "zh_CN.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" ];
  };

  nixpkgs.config.allowUnfree = true;

  sound.enable = true;

  environment.pathsToLink = [ "/share/fish" ];

  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var"
      "/root"
      "/etc/NetworkManager/system-connections"
    ];
    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/ssh/ssh_host_ed25519_key"
    ];
  };


  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.fish.enable = true;
  programs.adb.enable = true;
  programs.fuse.userAllowOther = true;
  services.flatpak.enable = true;

  systemd.services.nix-daemon = {
    environment = {
      TMPDIR = "/var/cache/nix";
    };
    serviceConfig = {
      CacheDirectory = "nix";
    };
  };

  documentation.nixos.enable = false;

  system.stateVersion = "23.11";
}

