{ config
, pkgs
, ...
}: {
  imports = [
    ./git
    ./fish
    ./kitty
    ./dconf
    ./firefox
    ./neovim
    ./vscode
    ./mpv
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
    options = [
      "--cmd cd"
    ];
  };

  programs.tealdeer = {
    enable = true;
  };

  programs.obs-studio = {
    enable = true;
  };
}
