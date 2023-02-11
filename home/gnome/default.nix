{ pkgs, lib, ... }:

{
  imports = [
    ./extensions.nix
    ./rime
    # ../services
  ];
  config = {
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    services.xserver.excludePackages = [ pkgs.xterm ]; # ???
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
      nautilus-open-any-terminal
    ]) ++ (with pkgs.gnome; [
      gnome-tweaks
      dconf-editor
      # loupe # https://github.com/NixOS/nixpkgs/pull/202692
      ghex
      gnome-sound-recorder
      gnome-power-manager
    ]);
  };
}
