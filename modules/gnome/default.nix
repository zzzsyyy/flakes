{ pkgs, lib, ... }:

{
  imports = [
    ./extensions.nix
  ];
  config = {
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    services.xserver.excludePackages = [ pkgs.xterm ];
    services.xserver.desktopManager.xterm.enable = false;
    services.xserver.gdk-pixbuf.modulePackages = with pkgs; [ libjxl-with-plugin ];
    services.gnome = {
      core-utilities.enable = false;
      gnome-online-accounts.enable = false;
      sushi.enable = true;
      gnome-browser-connector.enable = true;
    };
    environment.gnome.excludePackages = (with pkgs; [
      gnome-tour
      orca
      #]) ++ (with pkgs.gnome; [
    ]);
    programs.dconf.enable = true;
    environment.systemPackages = (with pkgs; [
      # celluloid # using mpv with osc
      amberol # music
      feh # image
      gnome-text-editor
    ]) ++ (with pkgs.gnome; [
      nautilus # file
      file-roller # archive
      evince # pdf
      gnome-tweaks
      gnome-calendar
      dconf-editor
      # loupe # https://github.com/NixOS/nixpkgs/pull/202692
      # gnome-sound-recorder
      # gnome-power-manager
    ]);
  };
}
