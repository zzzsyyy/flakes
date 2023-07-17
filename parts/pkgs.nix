{
  perSystem =
    { config
    , pkgs
    , ...
    }:
    let
      names = with builtins; attrNames (readDir ../pkgs);
      genPkg = name: {
        inherit name;
        value = pkgs.callPackage (../pkgs + "/${name}") { };
      };
    in
    {
      packages = builtins.listToAttrs (map genPkg names);
    };
}
