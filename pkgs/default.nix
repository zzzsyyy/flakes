rec{
  overlay = final: prev:
    let
      pkgs = prev;
      dirs = builtins.readDir ../pkgs;
      names = builtins.attrNames dirs;
      genPkg = name: {
        inherit name;
        value = final.callPackage (../pkgs + "/${name}") { };
      };
    in
    # {
      # firefox-ui-fix = pkgs.callPackage ./firefox-ui-fix { };
      # my-fonts = pkgs.callPackage (import ./my-fonts) { };
      # plangothic = pkgs.callPackage (import ./plangothic) { };
      # librime-lua = pkgs.callPackage (import ./librime-plugins/librime-lua) { };
      # librime-octagram = pkgs.callPackage (import ./librime-plugins/librime-octagram) { };
      # }
    builtins.listToAttrs (map genPkg names);
}
