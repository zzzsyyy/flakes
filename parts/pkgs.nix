{ inputs, self, lib, ... }:

{
  flake.overlays = builtins.listToAttrs (map
    (name: {
      name = lib.strings.removeSuffix ".nix" name;
      value = import (../overlays/${name});
    })
    (lib.filter (item: lib.strings.hasSuffix ".nix" item) (builtins.attrNames (builtins.readDir ../overlays)))
  );

  perSystem =
    { config
    , pkgs
    , system
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
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [
            "openssl-1.1.1w"
          ];
        };
        overlays = map (f: self.overlays.${f}) (builtins.attrNames self.overlays);
      };
      packages = builtins.listToAttrs (map genPkg names) // {
        mutter = pkgs.gnome.mutter;
      };
    };
}
