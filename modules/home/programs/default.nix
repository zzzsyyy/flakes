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

  programs.lsd = {
    enable = true;
    enableAliases = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    options = [
      #"--cmd cd"
    ];
  };

  programs.tealdeer = {
    enable = true;
  };
}
