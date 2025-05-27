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
