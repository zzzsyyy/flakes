(final: prev: {
  gnome = prev.gnome.overrideScope' (final': prev': {

    mutter = prev'.mutter.overrideAttrs (oldAttrs: {
      patches = (oldAttrs.patches or [ ]) ++ [

        #dynamic triple/double buffer
        (prev.fetchpatch {
          url = "https://raw.githubusercontent.com/archlinuxcn/repo/91cc9fbd658977c17e94441970e9482d9ac4b10b/archlinuxcn/mutter-performance/mr1441.patch";
          hash = "sha256-RebFUHrBOHBX8jFbYf8BuN3cYMaleaC/W8vyJ1zGFY8=";
        })
      ];
    });
  });
})

