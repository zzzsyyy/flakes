{ pkgs, ... }:

{
  programs.xwayland = {
    enable = true;
    package = pkgs.xwayland-satellite;
  };
  programs.niri.package = pkgs.niri-unstable;
  programs.niri.enable = true;
  systemd.user.services.niri-flake-polkit.enable = false;
  security.soteria.enable = true;
}
