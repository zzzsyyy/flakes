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
        "nightthemeswitcher@romainvigier.fr"
        "Rounded_Corners@lennart-k"
        "rounded-window-corners@yilozt"
        "customize-ibus@hollowman.ml"
      ];
    };
    "org/gnome/shell" = {
      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "firefox.desktop"
        "code.desktop"
        "org.telegram.desktop.desktop"
        "kitty.desktop"
      ];
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-and-drag-lock = true;
      tap-to-click = true;
      accel-profile = "adaptive";
      speed = 0.1;
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
    "org/gnome/shell/extensions/nightthemeswitcher/shell-variants" = {
      enabled = true;
      day = "Default-light";
    };
    "org/gnome/shell/extensions/nightthemeswitcher/gtk-variants" = {
      enabled = true;
      day = "adw-gtk3";
      night = "adw-gtk3-dark";
    };
  };
}
