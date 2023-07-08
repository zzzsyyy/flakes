{
  flake = {
    hmModules = {
      #@TODO
    };
    nixosModules = {
      flatpak-icons-workaround = import ../modules/nixos/flatpak-fix.nix;
      dae = import ../modules/nixos/dae.nix;
    };
  };
}
