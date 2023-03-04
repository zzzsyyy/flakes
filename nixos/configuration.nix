{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware.nix
    ];

  boot = {
    plymouth.enable = true;
    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 5;
      efi.canTouchEfiVariables = false; #@TODO
    };
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "quiet"
      "udev.log_level=3"
      "nowatchdog"
    ];
    supportedFilesystems = [ "ntfs" ];
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";


  time.timeZone = "Asia/Shanghai";

  i18n = {
    defaultLocale = "zh_CN.UTF-8";
    supportedLocales = [ "zh_CN.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" ];
  };

  nix = {
    package = pkgs.nixUnstable;
    settings.experimental-features = [ "nix-command" "flakes" ];
    settings.auto-optimise-store = true;
    settings.substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://mirror.sjtu.edu.cn/nix-channels/store"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
    ];
    gc = {
      automatic = true;
      options = "--delete-older-than 5d";
      dates = "Sun 14:00";
    };
  };

  nixpkgs.config.allowUnfree = true;

  sound.enable = true;
  hardware = {
    pulseaudio.enable = false;
    opengl.enable = true;
    bluetooth.enable = true;
    cpu.amd.updateMicrocode = true;
  };

  users = {
    mutableUsers = false;
    users.zzzsy = {
      hashedPassword = "$6$3mI6lDngcB2nrJx5$IG1j2hHtg0xhvrcFSO99zW1b8Lil4rgWLjgppTe3ALA1ftfLmDnHdAeuhtI/Zc0AwvsNThQIWxtAu/gHN1gfD1";
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "video" ];
    };
  };

  users.defaultUserShell = pkgs.zsh;
  environment.pathsToLink = [ "/share/zsh" ];
  environment.sessionVariables.TERMINAL = [ "wezterm" ];

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

  programs.fuse.userAllowOther = true;
  services = {
    openssh.enable = true;
    printing.enable = true;
    fwupd.enable = true;
    flatpak.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
      media-session.enable = false;
    };
    # zerotierone = {
    #   enable = true;
    #   joinNetworks = [ "" ];
    #   port = 9993; #default
    # };

  };

  systemd.services.nix-daemon = {
    environment = {
      TMPDIR = "/var/cache/nix";
    };
    serviceConfig = {
      CacheDirectory = "nix";
    };
  };

  documentation.nixos.enable = false;


  system.stateVersion = "unstable";
}

