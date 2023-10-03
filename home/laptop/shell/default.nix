{
  imports = [
    ./fish.nix
    ./git.nix
    ./kitty.nix
  ];
  programs.eza = {
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
  };
}
