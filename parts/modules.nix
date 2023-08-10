{
  flake = {
    hmModules = {
      #@TODO
    };
    nixosModules = {
      flatpak-icons-workaround = import ../modules/nixos/flatpak-fix.nix;
      daet = import ../modules/nixos/dae.nix;
    };
  };
}
