{ pkgs
, ...
}:
{
  home.packages = with pkgs; [
    grim
    # grimblast
    slurp
    wl-clipboard
    # wl-recorder
    swaylock
    rofi-wayland
    waybar
    gnome.nautilus
    feh
    gnome.file-roller
    evince
    hyprpaper
    wlogout
  ];
}
