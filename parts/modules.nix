{
  flake = {
    hmModules = {
      #@TODO
    };
    nixosModules = {
      flatpak-icons-workaround = import ../modules/nixos/flatpak-fix.nix;
      gnome-fix = import ../modules/nixos/gnome-fix.nix;
    };
  };
}
