{ config, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    dotDir = ".config/zsh";
    history = {
      path = "${config.xdg.cacheHome}/.histfile";
      size = 100000;
      save = 100000;
      expireDuplicatesFirst = true;
      ignorePatterns = [ ":q" "clc" ];
    };
    historySubstringSearch.enable = true;
    shellAliases = {
      pb = "curl -F 'c=@-' 'https://fars.ee/'";
      gst = "git status";
      n = "neofetch";
      setproxy = "export ALL_PROXY=socks://127.0.0.1:7890";
      unsetproxy = "unset ALL_PROXY";
      clc = "clear";
      ":q" = "exit";
      snvim = "EDITOR=nvim sudoedit";
    };
    dirHashes = {
      docs = "$HOME/Documents";
      code = "$HOME/Documents/Code";
      dl = "$HOME/Downloads";
    };
    initExtra = ''
      zstyle ':completion:*' menu select
      export PNPM_HOME="/home/zzzsy/.local/share/pnpm"
      export PATH="$PNPM_HOME:$PATH"
    '';
  };
}
