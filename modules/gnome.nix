{ pkgs, ... }: 
{
  config = {
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    environment.gnome.excludePackages = (with pkgs; [
      gnome-photos
      gnome-tour
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
      celluloid
      # firefox
    ]) ++ (with pkgs.gnome; [
      gnome-tweaks
      # loupe
      ghex
      gnome-sound-recorder
      gnome-power-manager
    ]);
  };
}