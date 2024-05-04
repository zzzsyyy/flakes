{ pkgs, ... }:

let
  extensions = with pkgs.gnomeExtensions; [
    user-themes
    gsconnect
    appindicator
    removable-drive-menu
    # clipboard-indicator 
    #!FIXME freeze my shell
    caffeine
    dash-to-panel
    # unite
    night-theme-switcher
    # rounded-window-corners
    customize-ibus
    # quake-mode
    fuzzy-app-search
    pano
  ];
in
{
  home.packages = extensions ++ [ ];
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = map (p: p.extensionUuid or p.uuid) extensions;
      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "firefox-beta.desktop"
        "code.desktop"
        "org.telegram.desktop.desktop"
        "kitty.desktop"
      ];
    };
    # @FIXME Cause ibus offset
    #"org/gnome/mutter" = {
    #  experimental-features = [
    #    "scale-monitor-framebuffer"
    #  ];
    #};
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-and-drag-lock = true;
      tap-to-click = true;
      accel-profile = "adaptive";
      speed = 0.2;
    };
    "org/gnome/desktop/peripherals/mouse".accel-profile = "adaptive";
    "org/gnome/desktop/interface" = {
      locale-pointer = true;
      show-battery-percentage = true;
    };
    "org/gnome/desktop/privacy" = {
      remove-old-temp-files = true;
      remove-old-trash-files = true;
      old-files-age = 14;
    };
    "org/gnome/shell/extensions/nightthemeswitcher/gtk-variants" = {
      enabled = true;
      day = "adw-gtk3";
      night = "adw-gtk3-dark";
    };
    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
      move-to-center = [ "<Super>c" ];
      toggle-fullscreen = [ "<Super>f" ];
      show-desktop = [ "<Super>d" ];
    };
    # "com/github/repsac-by/quake-mode" = {
    #   quake-mode-always-on-top = true;
    #   quake-mode-animation-time = 0.10;
    #   quake-mode-focusout = true;
    #   quake-mode-halign = "center";
    #   quake-mode-height = 70;
    #   quake-mode-hide-from-overview = true;
    #   quake-mode-tray = false;
    #   quake-mode-valign = "top";
    #   quake-mode-width = 60;
    # };

    # "com/github/repsac-by/quake-mode/accelerators" = {
    #   quake-mode-accelerator-1 = [ "<Super>k" ];
    # };

    # "com/github/repsac-by/quake-mode/apps" = {
    #   app-1 = "kitty.desktop";
    # };
  };
}

