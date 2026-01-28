{ inputs, lib, ... }:
{

  enabled = {
    enable = true;
  };

  disabled = {
    enable = false;
  };

  infuse = (import inputs.infuse.outPath { inherit lib; }).v1.infuse;

  # Auto-import all .nix files in a directory (excluding default.nix)
  # excludes: list of filenames to exclude (e.g. ["external.nix"])
  importModules =
    dir:
    let
      files = if builtins.pathExists dir then builtins.readDir dir else { };
      nixFiles = lib.filterAttrs (
        name: type: type == "regular" && name != "default.nix" && lib.hasSuffix ".nix" name
      ) files;
    in
    lib.mapAttrs' (name: _: {
      name = lib.removeSuffix ".nix" name;
      value = import (dir + "/${name}");
    }) nixFiles;

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
