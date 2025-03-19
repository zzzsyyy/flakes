{ pkgs, ... }:

{
  imports = [
    ./gnome
    ./rime
    ./fonts.nix
    ./hardware.nix
    ./services.nix
    ./virt.nix
    ./networking.nix
    ./sops.nix
    ./lanzaboote.nix
    ./btrbk.nix
    ./persist.nix
  ];

  # stylix.enable = true;

  services = {
    scx.enable = true;
    scx.package = pkgs.scx_git.full;
    scx.scheduler = "scx_lavd";
  };

  mods.thinkbook14p-fix.enable = true;

  boot = {
    plymouth.enable = true;
    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 5;
      efi.canTouchEfiVariables = false; # @TODO
    };
    # kernelPackages = pkgs.linuxPackages_latest;
    kernelPackages = pkgs.linuxPackages_cachyos;
    #@TODO
    kernelParams = [
      "amd_pstate=active"
      # "amd_iommu=off"
      "pti=on"
      "log_level=3"
      "nowatchdog"
    ];
    supportedFilesystems = [ "ntfs" ];
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.TERMINAL = [ "kitty" ];
  environment.variables."EDITOR" = "hx"; # @TODO https://github.com/nix-community/home-manager/issues/4969

  time.timeZone = "Asia/Shanghai";

  i18n = {
    defaultLocale = "zh_CN.UTF-8";
    supportedLocales = [
      "zh_CN.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
    ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.pathsToLink = [ "/share/fish" ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.fish.enable = true;
  programs.wireshark.enable = true;
  environment.systemPackages = [
    pkgs.wireshark
  ];
  #programs.thefuck.enable = true;
  programs.adb.enable = true;
  programs.fuse.userAllowOther = true;
  services.flatpak.enable = true;
  security.rtkit.enable = true;

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
