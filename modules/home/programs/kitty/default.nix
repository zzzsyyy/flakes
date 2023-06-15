{ ... }:

{
  programs.kitty = {
    enable = true;
    font.name = "Iosevka ZT";
    font.size = 12;
    shellIntegration.enableFishIntegration = true;
    settings = {
      enable_audio_bell = false;
      update_check_interval = 0;
      background_opacity = "0.95";
      hide_window_decorations = true;
    };
    theme = "Nord";
  };
}
