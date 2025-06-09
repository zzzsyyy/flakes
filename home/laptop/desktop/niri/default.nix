{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    fuzzel
    xsel
    hyprpaper
  ];
  xdg.enable = true;
  xdg.portal = with pkgs; {
    enable = true;
    configPackages = [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
      xdg-desktop-portal
    ];
    extraPortals = [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
      xdg-desktop-portal
    ];
    xdgOpenUsePortal = true;
  };
  programs.waybar = {
    enable = true;
    style = builtins.readFile ./waybar/style.css;
    settings = builtins.fromJSON (builtins.readFile ./waybar/config.jsonc);
  };

  xdg.configFile."niri/config.kdl".source = pkgs.replaceVars ./niri.kdl {
      brightnessctl = "${lib.getExe pkgs.brightnessctl}";
      startXwayland = pkgs.writeText "a.sh" ''
        sleep 3
        xwayland-satellite :0
      '';
      DEFAULT_AUDIO_SINK = null;
      DEFAULT_AUDIO_SOURCE = null;
    };
}
