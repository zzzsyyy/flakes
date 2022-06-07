{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./kitty.nix
    ./git.nix
  ];
  programs = {
    waybar = {
      enable = true;
      settings = [ (import ./waybar.nix) ];
      style = builtins.readFile ./waybar.css;
      systemd.enable = true;
    };
  };
}
