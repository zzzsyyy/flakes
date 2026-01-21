{inputs, ...}:

{
  flake = {
    hmModules = {
      s = inputs.noctalia.homeModules.default;
    };
    nixosModules = {
      gnome-fix = import ../modules/nixos/gnome-fix.nix;
    };
  };
}
