{ pkgs, ... }: 
{
  config = {
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    # services.xserver.excludePackages = [ pkgs.xterm ]; # ???
    environment.gnome.excludePackages = (with pkgs; [
      gnome-photos
      gnome-tour
      gnome-console
    ]) ++ (with pkgs.gnome; [
      cheese # webcam tool
      gnome-music
      epiphany # web browser
      geary # email reader
      gnome-characters
      yelp # Help view
      gnome-contacts
      totem # video player
      gnome-maps
      gnome-weather
    ]);
    programs.dconf.enable = true;
    environment.systemPackages = (with pkgs; [
      gnome-firmware
      celluloid # video
      amberol # music
      blackbox-terminal
    ]) ++ (with pkgs.gnome; [
      gnome-tweaks
      dconf-editor
      # loupe
      ghex
      gnome-sound-recorder
      gnome-power-manager
    ]) ++ (with pkgs.gnomeExtensions; [
      user-themes
      gsconnect
      appindicator
      removable-drive-menu
      clipboard-indicator
      date-menu-formatter
      openweather
      bluetooth-quick-connect
      caffeine
      dash-to-panel
      # sound-output-device-chooser
      unite
      dash-to-dock
      night-theme-switcher
      rounded-window-corners
      rounded-corners
      customize-ibus
      space-bar
      workspace-switcher-manager
      fuzzy-app-search
    ]);
  };
}
