{ pkgs, ... }:

{
  programs.xwayland = {
    enable = true;
    package = pkgs.xwayland-satellite;
  };
  programs.niri.package = pkgs.niri-unstable;
  programs.niri.enable = true;
}
