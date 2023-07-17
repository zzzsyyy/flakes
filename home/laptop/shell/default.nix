{ pkgs
, ...
}: {
  imports = [
    ./fish.nix
    ./git.nix
    ./kitty.nix
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

  home.shellAliases = {
    pb = "curl -F 'c=@-' 'https://fars.ee/'";
    gst = "git status";
    n = "neofetch";
    setproxy = "export ALL_PROXY=socks://127.0.0.1:7890";
    unsetproxy = "unset ALL_PROXY";
    clc = "clear";
    ":q" = "exit";
    snvim = "EDITOR=nvim sudoedit";
    icat = "kitty +kitten icat";
  };
}
