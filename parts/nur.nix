{ pkgs }:
let
  pkgExclude = [ ];
  sources = pkgs.callPackage ../pkgs/_sources/generated.nix { };
  names =
    ../pkgs
    |> builtins.readDir
    |> builtins.mapAttrs (
      k: v: if v == "directory" && k != "_sources" && !(builtins.elem k pkgExclude) then k else null
    )
    |> builtins.attrValues
    |> builtins.filter (v: v != null);
  genPkg =
    name:
    let
      package = import (../pkgs + "/${name}");
    in
    {
      inherit name;
      value = pkgs.callPackage (../pkgs + "/${name}") (
        builtins.intersectAttrs (builtins.functionArgs package) { source = sources.${name}; }
      );
    };

in

builtins.listToAttrs (map genPkg names) // { }
