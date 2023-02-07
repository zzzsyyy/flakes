{ config
, pkgs
, ...
}: {
  imports = [
    ./git
    ./starship
    ./wezterm
    ./dconf
    ./firefox
    ./zsh
    # ./neovim
    ./vscode
    ./mpv
  ];

  programs.lsd = {
    enable = true;
    enableAliases = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [
      # "--cmd cd"
    ];
  };
}
