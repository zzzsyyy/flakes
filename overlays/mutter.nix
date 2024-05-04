(final: prev: {
  gnome = prev.gnome.overrideScope (final': prev': {

    mutter = prev'.mutter.overrideAttrs (oldAttrs: {
      patches = (oldAttrs.patches or [ ]) ++ [

        #dynamic triple/double buffer
        (prev.fetchpatch {
          url = "https://raw.githubusercontent.com/archlinuxcn/repo/9416cb712590279a2b3b9e887e941bf85ee0c8f9/archlinuxcn/mutter-performance/mr1441.patch";
          hash = "sha256-WBY9hsOE7S2sXgqj5gJuhCkG/XIXh68a+TTUIuPbZmk=";
        })
      ];
    });
  });
})

