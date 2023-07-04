{ lib
, config
, nixosConfig
, pkgs
, ...
}: {
  imports = [
    ./mpv
    ./neovim
    ./firefox
    ./desktop.nix
    # ./dev.nix
    ./fish.nix
    ./kitty.nix
    ./pkgs.nix
  ];

  programs.exa = {
    enable = true;
    enableAliases = true;
    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
    icons = true;
    git = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.tealdeer = {
    enable = true;
  };
}
