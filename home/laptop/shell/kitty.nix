{
  programs.kitty = {
    enable = true;
    font.name = "Iosevka ZT Extended";
    font.size = 12;
    shellIntegration.enableFishIntegration = true;
    settings = {
      enable_audio_bell = false;
      remember_window_size = false;
      # initial_window_width = 800;
      # initial_window_height = 600;
      update_check_interval = 0;
      background_opacity = "0.95";
      hide_window_decorations = true;
      tabs = true;
      tab_bar_style = "powerline";
    };
    # https://github.com/kovidgoyal/kitty-themes/blob/master/themes.json
    theme = "Everforest Dark Soft";
  };
}
