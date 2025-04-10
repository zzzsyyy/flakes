{ infuse }:
final: prev:
infuse prev {
  mutter.__output.patches.__append = [
    ../patches/mutter-triple-buffering.patch
    ../patches/mutter-text-input-v1.patch
    # 4345 4371w
  ];
  gnome-shell.__output.patches.__append = [
    ../patches/gnome-shell-preedit-fix.patch
  ];
}
