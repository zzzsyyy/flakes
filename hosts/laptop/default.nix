{ config, pkgs, inputs, ... }:

{
  imports = [
    ./configuration.nix
    ./fonts
    ./gnome
    ./rime
    ./networking
    ./services.nix
    # ../../modules/fonts
    # ../../modules/rime
    # ../../modules/networking
    # ../../modules/gnome
    # ../../modules/sops
    #../../modules/flatpak
    # ../../modules/virt
    # ../../modules/home
  ];
}
