{
  imports = [
    ./langs.nix
  ];

  programs.helix = {
    enable = true;
    # package = 
    settings = {
      theme = "everforest_dark";
      editor = {
        line-number = "relative";
        true-color = true;
        color-modes = true;
        cursorline = true;
        bufferline = "multiple";
        completion-replace = true;
        gutters = [ "diff" "diagnostics" "line-numbers" "spacer" ];
        statusline = {
          left = [ "mode" "spinner" ];
          center = [ "file-name" ];
          right = [ "diagnostics" "selections" "position" "file-line-ending" "file-type" "version-control" ];
          separator = "|";
          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
          };
        };
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides = {
          render = true;
          skip-levels = 1;
          character = "▏";
        };
        whitespace = {
          render = {
            space = "all";
          };
        };
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
      };
    };
  };
}
