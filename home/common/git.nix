{
  programs.git = {
    enable = true;
    userEmail = "me@zzzsy.top";
    userName = "zzzsyyy";
    signing = {
      signByDefault = true;
      key = "3F2409FFE586FB7F";
    };
    aliases = {
      tree = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all";
    };
    extraConfig = {
      merge.conflictStyle = "diff3";
      pull.rebase = true;
      init.defaultBranch = "main";
      fetch.prune = true;
    };
    delta.enable = true;
  };
}
