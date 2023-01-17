{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware.nix
    ];

  boot = { 
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = false;
    };
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "quite"
      "udev.log_level=3"
      "nowatchdog"
    ];
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

   networking.hostName = "zzzsy";
   networking.networkmanager.enable = true;

   time.timeZone = "Asia/Shanghai";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  i18n = {
    defaultLocale = "zh_CN.UTF-8";
    inputMethod = {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [ rime ];
    };
  };
  i18n.supportedLocales = [ "zh_CN.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" ];

  fonts = {
    enableDefaultFonts = true;
    fontconfig.enable = true;
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
      fira-code
      sarasa-gothic
      noto-fonts
      noto-fonts-emoji
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

  services.xserver = {
    layout = "us";
    libinput.enable = true;
  };

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
    packages = with pkgs; [
      vscode-fhs
    ];
  };

  users.defaultUserShell = pkgs.zsh;
  environment.pathsToLink = [ "/share/zsh" ];
  environment.systemPackages = with pkgs; [
    neovim
    git
    neofetch
    gnomeExtensions.user-themes
  ];

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
    # bind.enable = true;
    # zerotierone = {
    #   enable = true;
    #   joinNetworks = [ "" ];
    #   port = 9993; #default
    # };

  };


  system.stateVersion = "unstable"; # Did you read the comment?
}

