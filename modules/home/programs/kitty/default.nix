{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font.name = "Iosevka ZT";
    font.size = 12;
    shellIntegration.enableFishIntegration = true;
    settings = {
      background_opacity = "0.95";
      hide_window_decorations = true;
    };
    theme = "Nord";
  };
}
