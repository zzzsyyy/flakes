{ config, pkgs, inputs, ... }:

{
  imports = [
    ./configuration.nix
    ../../modules/fonts
    ../../modules/rime
    ../../modules/networking
    ../../modules/gnome
    ../../modules/sops
    #../../modules/flatpak
    ../../modules/virt
    # ../../modules/home
  ];
}
