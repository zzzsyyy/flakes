{ pkgs, ... }:

let
  extensions = with pkgs.gnomeExtensions; [
    user-themes
    screenshot-window-sizer
    gsconnect
    appindicator
    removable-drive-menu
    caffeine
    dash-to-panel
    # rounded-window-corners
    customize-ibus
    light-style
    fuzzy-app-search
    # pano
    kimpanel
    gtk4-desktop-icons-ng-ding
  ];
in
{
  home.packages = extensions ++ [ pkgs.my.gnome-shell-extension-pano ];
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
    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
    };
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
      old-files-age = 21;
    };
    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
      move-to-center = [ "<Super>c" ];
      toggle-fullscreen = [ "<Super>f" ];
      show-desktop = [ "<Super>d" ];
    };
  };
}
