{ lib
, config
, nixosConfig
, pkgs
, ...
}: {
  imports = [
    ./desktop
    ./dev.nix
    ./fish.nix
    ./kitty.nix
    ./neovim
    ./pkgs.nix
    ./mpv
    ./firefox
  ];

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-gstreamer
      obs-vaapi
    ];
  };

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
