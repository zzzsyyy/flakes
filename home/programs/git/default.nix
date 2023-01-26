{
    programs.git = {
      enable = true;
      userEmail = "me@zzzsy.top";
      userName = "zzzsyyy";
      signing = {
        signByDefault = true;
        key = "3F2409FFE586FB7F";
      };
      extraConfig = {
        merge.conflictStyle = "diff3";
        pull.rebase = true;
        init.defaultBranch = "main";
        fetch.prune = true;
      };
    };
}
