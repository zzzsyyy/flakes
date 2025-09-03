{
  config,
  pkgs,
  ...
}:
let
  idlehandler = pkgs.writeShellScriptBin "sway-idlehandler" ''
    swayidle -w timeout 300 'swaylock --grace 70' before-sleep 'swaylock' timeout 360 'swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"'
  '';
in
{
  home.packages = with pkgs; [
    fuzzel
    xsel
    hyprpaper
    wl-clipboard
    idlehandler
    swayidle
    swaylock-effects
    swayosd
    wdisplays
    clipse
    bluetui
    swaynotificationcenter
    better-control
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
    #style = builtins.readFile ./waybar/style.css;
    #settings = builtins.fromJSON (builtins.readFile ./waybar/config.jsonc);
  };
  xdg.configFile."waybar/config".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/flakes/home/laptop/desktop/niri/waybar/config.jsonc";
  xdg.configFile."waybar/style.css".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/flakes/home/laptop/desktop/niri/waybar/style.css";
  xdg.configFile."niri/config.kdl".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/flakes/home/laptop/desktop/niri/niri.kdl";
  #xdg.configFile."niri/config.kdl".source = pkgs.replaceVars ./niri.kdl {
  #    brightnessctl = "${lib.getExe pkgs.brightnessctl}";
  #    DEFAULT_AUDIO_SINK = null;
  #    DEFAULT_AUDIO_SOURCE = null;
  #  };
}
