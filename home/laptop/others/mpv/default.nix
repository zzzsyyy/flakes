{ pkgs, ... }:

{
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [ uosc ];
    config = {
      profile = "gpu-hq";
      hwdec = "auto-safe";
      gpu-context = "wayland";
      hwdec-codecs = "vaapi";
      blend-subtitles = "video";
      sub-auto = "fuzzy";
      cscale-param2 = "spline36";
      interpolation = "yes";
    };
  };
}
