{
  flake = {
    hmModules = {
      #@TODO
    };
    nixosModules = {
      flatpak-icons-workaround = import ../modules/nixos/flatpak-icons-workaround.nix;
    };
  };
}
