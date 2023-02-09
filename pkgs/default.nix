final: prev:
{ } // (
  let
    pkgs = prev;
  in
  {
    firefox-ui-fix = pkgs.callPackage ./firefox-ui-fix { };
    my-fonts = pkgs.callPackage (import ./my-fonts) { };
    plangothic = pkgs.callPackage (import ./plangothic) { };
    librime-lua = pkgs.callPackage (import ./librime-plugins/librime-lua) { };
    librime-octagram = pkgs.callPackage (import ./librime-plugins/librime-octagram) { };
  }
)
