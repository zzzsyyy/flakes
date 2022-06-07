{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./git.nix
  ];
  programs = {
    waybar = {
      enable = true;
      settings = (import ./waybar.nix);
      style = builtins.readFile ./waybar.css;
      systemd.enable = true;
    };
    kitty = {
      enable = true;
      extraConfig = builtins.readFile (./kitty.conf);
    };
  };
}
