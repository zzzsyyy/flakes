{
  flake = {
    hmModules = {
      #@TODO
    };
    nixosModules = {
      flatpak-icons-workaround = import ../modules/nixos/flatpak-fix.nix;
      dae = import ../modules/nixos/dae.nix;
      gnome-fix = import ../modules/nixos/gnome-fix.nix;
      # sing-box = import ../modules/nixos/sing-box.nix;
    };
  };
}
