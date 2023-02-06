{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "dash-to-panel@jderose9.github.com"
        "drive-menu@gnome-shell-extensions.gcampax.github.com"
        "unite@hardpixel.eu"
        "appindicatorsupport@rgcjonas.gmail.com"
        "caffeine@patapon.info"
        "clipboard-indicator@tudmotu.com"
        "date-menu-formatter@marcinjakubowski.github.com"
        "gsconnect@andyholmes.github.io"
        "openweather-extension@jenslody.de"
        "bluetooth-quick-connect@bjarosze.gmail.com"
        "nightthemeswitcher@romainvigier.fr"
        "Rounded_Corners@lennart-k"
        "rounded-window-corners@yilozt"
        "customize-ibus@hollowman.ml"
        "dash-to-dock@micxgx.gmail.com"
        "space-bar@luchrioh"
      ];
    };
    "org.gnome.desktop.peripherals.touchpad" = {
      tap-and-drag-lock = true;
      tap-to-click = true;
      accel-profile = "adaptive";
      speed = 0.3;
    };
    "org.gnome.desktop.peripherals.mouse".accel-profile = "adaptive";
    "org.gnome.desktop.interface" = {
      locale-pointer = true;
      show-battery-percentage = true;
    };
    "org.gnome.desktop.privacy" = {
      remove-old-temp-files = true;
      remove-old-trash-files = true;
      old-files-age = 14;
    };
  };
}
