{ pkgs, ... }:

{
  imports = [ ];
  config = {
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      excludePackages = [ pkgs.xterm ];
      desktopManager.xterm.enable = false;
    };
    services.gnome = {
      core-apps.enable = false;
      gnome-online-accounts.enable = false;
      gnome-browser-connector.enable = true;
      localsearch.enable = false;
      tinysparql.enable = false;
    };
    programs.kdeconnect = {
      enable = true;
      package = pkgs.valent;
    };
    environment.gnome.excludePackages = (
      with pkgs;
      [
        gnome-tour
        orca
      ]
    );

    xdg.terminal-exec = {
      enable = true;
      settings = {
        default = [ "kitty.desktop" ];
      };
    };

    programs.dconf.enable = true;
    # fix nautilus extensions deu to `core-utilities.enable = false`
    mods.gnome-fix.enable = true;
    environment.systemPackages = (
      with pkgs;
      [
        ffmpegthumbnailer
        amberol # music
        loupe # image
        gnome-text-editor
        epiphany
        #papers
        evince
        nautilus # file
        file-roller # archive
        gnome-tweaks
        refine
        gnome-disk-utility
        seahorse
        gnome-calendar
        dconf-editor
      ]
    );
  };
}
