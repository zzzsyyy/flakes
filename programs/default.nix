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
}
