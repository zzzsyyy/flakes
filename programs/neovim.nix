{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    extraConfig = ''
      set viminfo+=n${config.xdg.stateHome}/viminfo
      lua << EOT
      ${builtins.readFile ./neovim.lua}
      EOT
    '';
  };
}
