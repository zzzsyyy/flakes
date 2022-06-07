{
  config,
  lib,
  pkgs,
  ...
}: {
    programs.git = {
      enable = true;
      userEmail = "me@zzzsy.top";
      userName = "zzzsyyy";
      signing = {
        signByDefault = true;
        key = "9D0B573DAE953E10CF88E4E24047E6EB114E629F";
      };
      extraConfig = {
        merge.conflictStyle = "diff3";
        merge.tool = "vimdiff";
        mergetool = {
          keepBackup = false;
          keepTemporaries = false;
          writeToTemp = true;
        };
        pull.rebase = true;
        init.defaultBranch = "main";
        fetch.prune = true;
      };
    };
}
