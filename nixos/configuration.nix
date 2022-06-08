{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware.nix
      ../pkgs
    ];

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        useOSProber = false;
        efiSupport = true;
#        theme = pkgs.
      };
    };
#    kernelPackages = pkgs.linuxPackages_lqx;
    kernelParams = [
      "quiet"
      "udev.log_level=3"
      "nowatchdog"
    ];
  };

  # Allow Unfree pkgs
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };

  networking = {
    hostName = "zzzsy";
    firewall.enable = false;
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Shanghai";

  i18n = {
    defaultLocale = "zh_CN.UTF-8";
    supportedLocales = [ "zh_CN.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" ];
    inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [ fcitx5-rime ];
      fcitx5.enableRimeData = true;
    };
  };

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

  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    binaryCaches = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
    ];
    gc = {
      automatic = true;
      options = "--delete-older-than 5d";
      dates = "Sun 14:00";
    };
    autoOptimiseStore = true;
  };

  sound.enable = true;
  hardware = {
    pulseaudio.enable = false;
    opengl.enable = true;
    bluetooth.enable = true;
  };


  services = {
    gvfs.enable = true;
    davfs2.enable = true;
    printing.enable = true;
    blueman.enable = true;
    openssh.enable = true;
    avahi = {
      enable = true;
      nssmdns = true;
      publish = {
        enable =  true;
	userServices = true;
      };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
      media-session.enable = false;
      };
    locate = {
    	enable = true;
	locate = pkgs.plocate;
	localuser = null;
	pruneBindMounts = false;
    };
  };
  xdg.portal.wlr.enable = true;
  xdg.portal.gtkUsePortal = true;
  programs = {
#    starship = {
#      enable = true;
#    };
    sway = {
      enable = true;
      wrapperFeatures = {
        gtk = true;
      };
      extraPackages = with pkgs; [
        swaylock
        swayidle
        rofi
    #    light
        autotiling
        wofi
      ];
    };
    xwayland = {
      enable = true;
    };
#    neovim = {
#      enable = true;
#      vimAlias = true;
#      defaultEditor = true;
#      viAlias = true;
#    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    steam.enable = true;
    light.enable = true;
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
    };
  };

  users.users.zzzsy = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" "video" ];
   };
  users.defaultUserShell = pkgs.zsh;

  # system.copySystemConfiguration = true;

  system.stateVersion = "unstable";
}

