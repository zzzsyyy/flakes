{ pkgs, ... }:

{
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      uosc
    ];
  };
  home.file.".config/mpv/mpv.conf".source = ./mpv.conf;
}
