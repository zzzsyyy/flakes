{ pkgs, ... }:

{
  imports = [ ];
  config = {
    services.xserver = {
      enable = true;
      excludePackages = [ pkgs.xterm ];
      desktopManager.xterm.enable = false;
    };
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = false;
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
    programs.gtklock = {
      enable = true;
      config = {
        main = {
          follow-focus = true;
          start-hidden = true;
        };
        powerbar.show-labels = true;
      };
      style = ''
        #playerctl-revealer {
          padding-bottom: 100px
        }
        #powerbar-revealer {
          padding-bottom: 10px
        }
        window{background-image:url("/home/zzzsy/.local/share/background");background-size:cover}
        #playerctl-revealer{padding-bottom:100px}
        #powerbar-revealer{padding-bottom:10px}
      '';
      modules = with pkgs; [
        gtklock-playerctl-module
        gtklock-powerbar-module
      ];
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
        # epiphany
        papers
        nautilus # file
        file-roller # archive
        gnome-tweaks
        # refine
        gnome-disk-utility
        seahorse
        # gnome-calendar
        # dconf-editor
        poop
        comma
      ]
    );
  };
}
