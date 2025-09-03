{ infuse }:
final: prev:
infuse prev {
  mutter.__output.patches.__append = [
    ../patches/mutter-text-input-v1.patch
  ];
  gnome-shell.__output.patches.__append = [
    ../patches/gnome-shell-preedit-fix.patch
  ];
}
// {

  qt6Packages = prev.qt6Packages.overrideScope (
    _final': prev': {
      fcitx5-with-addons = prev'.fcitx5-with-addons.override { libsForQt5.fcitx5-qt = null; };
      fcitx5-configtool = prev'.fcitx5-configtool.override { kcmSupport = false; };
      fcitx5-chinese-addons =
        (prev'.fcitx5-chinese-addons.override {
          qtwebengine = null;
        }).overrideAttrs
          (oldAttrs: {
            cmakeFlags = (oldAttrs.cmakeFlags or [ ]) ++ [
              (prev.lib.cmakeBool "ENABLE_BROWSER" false)
            ];
          });
    }
  );
  xdg-desktop-portal-gtk =
    (prev.xdg-desktop-portal-gtk.override {
      gnome-settings-daemon = null;
      gnome-desktop = null;
      gsettings-desktop-schemas = null;
    }).overrideAttrs
      (oldAttrs: {
        mesonFlags = (oldAttrs.mesonFlags or [ ]) ++ [ (prev.lib.mesonEnable "wallpaper" false) ];
      });
}
