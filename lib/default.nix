{ inputs, lib, ... }:
let
  inherit (lib) mkOption types;
in
rec {

  enabled = {
    enable = true;
  };

  disabled = {
    enable = false;
  };

  infuse = (import inputs.infuse.outPath { inherit lib; }).v1.infuse;

  genPkgs =
    pkgs: sources: pkgPath: filterFn:
    let
      names =
        pkgPath
        |> builtins.readDir
        |> builtins.mapAttrs (k: v: if v == "directory" && k != "_sources" && filterFn k then k else null)
        |> builtins.attrValues
        |> builtins.filter (v: v != null);
      genPkg =
        name:
        let
          package = import (pkgPath + "/${name}");
        in
        {
          inherit name;
          value = pkgs.callPackage (pkgPath + "/${name}") (
            builtins.intersectAttrs (builtins.functionArgs package) { source = sources.${name}; }
          );
        };
    in
    builtins.listToAttrs (map genPkg names);
}
