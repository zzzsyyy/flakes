{
  inputs,
  lib,
  self,
  ...
}:

{
  flake.overlays =
    ../overlays
    |> builtins.readDir
    |> builtins.attrNames
    |> lib.filter (item: lib.strings.hasSuffix ".nix" item)
    |> map (name: {
      name = lib.strings.removeSuffix ".nix" name;
      value = import ../overlays/${name};
    })
    |> builtins.listToAttrs;

  perSystem =
    { pkgs, system, ... }:
    let
      nur = import ./nur.nix { inherit pkgs; };
      overlays = builtins.attrValues self.overlays;
    in
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system overlays;
        config.allowUnfree = true;
      };
      packages =
        builtins.removeAttrs nur [
          "overlays"
          "modules"
        ]
        // {
          mutter = pkgs.mutter;
          gnome-shell = pkgs.gnome-shell;
        };
    };
}
