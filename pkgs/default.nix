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
    builtins.listToAttrs (map genPkg names);
}
