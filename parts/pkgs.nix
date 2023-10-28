{
  perSystem =
    { config
    , pkgs
    , ...
    }:
    let
      sources = pkgs.callPackage ../pkgs/_sources/generated.nix { };
      names = with builtins; filter
        (v: v != null)
        (attrValues
          (mapAttrs
            (k: v: if v == "directory" && k != "_sources" then k else null)
            (readDir ../pkgs)
          )
        );
      genPkg = name:
        let package = import (../pkgs + "/${name}"); in
        {
          inherit name;
          value = pkgs.callPackage (../pkgs + "/${name}")
            (builtins.intersectAttrs
              (builtins.functionArgs package)
              { source = sources.${name}; }
            );
        };
    in
    {
      packages = builtins.listToAttrs (map genPkg names) // {
        megasync = pkgs.megasync;
      };
    };
}
