{
  imports = [
    ./fish.nix
    ./git.nix
    ./kitty.nix
    ./starship.nix
  ];
  programs.eza = {
    enable = true;
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

  programs.zellij = {
    enable = true;
    settings = {
      theme = "everforest-dark";
      simplified-ui = true;
    };
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "everforest-dark-medium";
    };
  };

  programs.tealdeer = {
    enable = true;
  };

  programs.atuin = {
    enable = true;
    flags = [
      "--disable-up-arrow"
      "--disable-ctrl-r"
    ];
    settings = {
      sync_frequency = "15m";
      dialect = "us";
    };
  };

  home.file.".config/neofetch/config.conf".text = import ./neofetch.nix;
  home.shellAliases = {
    pb = "curl -F 'c=@-' 'https://fars.ee/'";
    gst = "git status";
    n = "hyfetch";
    setproxy = "export ALL_PROXY=socks://127.0.0.1:7890";
    unsetproxy = "unset ALL_PROXY";
    clc = "clear";
    ":q" = "exit";
    snvim = "EDITOR=nvim sudoedit";
    icat = "kitty +kitten icat";
    s = "kitten ssh";
  };
}
