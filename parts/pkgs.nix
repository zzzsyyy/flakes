{
  inputs,
  lib,
  self,
  ...
}:

let
  mkOverlay =
    name:
    let
      path = ../overlays/${name};
      overlay = import path;
      args = builtins.functionArgs overlay;
    in
    if args ? infuse then
      overlay { inherit (lib.my) infuse; }
    else if args == { } then
      overlay
    else
      overlay (lib.intersectAttrs args { inherit inputs self lib; });
in
{
  flake.overlays =
    ../overlays
    |> builtins.readDir
    |> builtins.attrNames
    |> lib.filter (item: lib.strings.hasSuffix ".nix" item)
    |> map (name: {
      name = lib.strings.removeSuffix ".nix" name;
      value = mkOverlay name;
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
      packages = allPkgs // { };
    };
}
