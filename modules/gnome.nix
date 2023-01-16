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
    ]);
    programs.dconf.enable = true;
    environment.systemPackages = with pkgs; [
      gnome.gnome-tweaks
    ];
  };
}