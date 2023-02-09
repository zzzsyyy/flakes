{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware.nix
    ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = false;
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

  fonts = {
    enableDefaultFonts = true;
    fontconfig.enable = true;
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
      fira-code
      my-fonts
      plangothic
      sarasa-gothic
      noto-fonts
      noto-fonts-emoji
      maple-mono
    ];
  };

  nix = {
    package = pkgs.nixUnstable;
    settings.experimental-features = [ "nix-command" "flakes" ];
    settings.auto-optimise-store = true;
    settings.substituters = [
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

  users.users.zzzsy = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  users.defaultUserShell = pkgs.zsh;
  environment.pathsToLink = [ "/share/zsh" ];
  environment.sessionVariables.TERMINAL = [ "wezterm" ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

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

  documentation.nixos.enable = false;


  system.stateVersion = "unstable"; # Did you read the comment?
}

