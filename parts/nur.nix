{ pkgs, lib }:
let
  pkgInclude = [
    "firefox-gnome-theme"
    "librime-lua"
    "lxgw-wenkai-screen"
    "plangothic"
    "rime-ice"
  ];
  sources = pkgs.callPackage ../pkgs/_sources/generated.nix { };
in

lib.my.genPkgs pkgs sources ../pkgs (k: builtins.elem k pkgInclude) // { }
