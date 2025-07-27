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
      value = import ../overlays/${name} { inherit (lib.my) infuse; };
    })
    |> builtins.listToAttrs;

  perSystem =
    { pkgs, system, ... }:
    let
      # nur = import ./nur.nix { inherit pkgs lib; };
      sources = pkgs.callPackage ../pkgs/_sources/generated.nix { };
      allPkgs = lib.my.genPkgs pkgs sources ../pkgs (k: true);
      overlays = builtins.attrValues self.overlays;
    in
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system overlays;
        config.allowUnfree = true;
        config.allowInsecure = true;
      };
      packages = allPkgs // {
        mutter = pkgs.mutter;
        gnome-shell = pkgs.gnome-shell;
      };
    };
}
