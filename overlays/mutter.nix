(final: prev: {
  mutter = prev.mutter.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or [ ]) ++ [
      ../patches/mutter-triple-buffering.patch
      ../patches/mutter-text-input-v1.patch
    ];
  });
  gnome-shell = prev.gnome-shell.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or [ ]) ++ [ ../patches/gnome-shell-preedit-fix.patch ];
  });
})
