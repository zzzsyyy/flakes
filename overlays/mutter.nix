(final: prev: {
  gnome = prev.gnome.overrideScope (final': prev': {

    mutter = prev'.mutter.overrideAttrs (oldAttrs: {
      patches = (oldAttrs.patches or [ ]) ++ [

        #dynamic triple/double buffer
        (prev.fetchpatch {
          url = "https://raw.githubusercontent.com/archlinuxcn/repo/e539f49338408e8a3d33d7618cec2641b5d63ce5/archlinuxcn/mutter-performance/mr1441.patch";
          hash = "sha256-Nup+3/oGXTaeXy0shNbVRoygT9DVy6hiKBf8b1v97Wk=";
        })
      ];
    });
  });
})

