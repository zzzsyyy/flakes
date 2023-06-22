{ config, pkgs, ... }:

{
  imports = [
    ./configuration.nix
    ../../modules/fonts
    ../../modules/rime
    ../../modules/networking
    ../../modules/gnome
    ../../modules/sops
    #../../modules/flatpak
    # ../../modules/home
  ];
}
