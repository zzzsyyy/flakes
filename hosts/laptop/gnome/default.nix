{ pkgs, lib, ... }:

{
  imports = [
    ./extensions.nix
  ];
  config = {
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      excludePackages = [ pkgs.xterm ];
      desktopManager.xterm.enable = false;
    };
    services.gnome = {
      core-utilities.enable = false;
      gnome-online-accounts.enable = false;
      sushi.enable = true;
      gnome-browser-connector.enable = true;
    };
    environment.gnome.excludePackages = (with pkgs; [
      gnome-tour
      orca
    ]);
    programs.dconf.enable = true;

    environment.systemPackages = (with pkgs; [
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
      gnome-disk-utility
      # loupe # https://github.com/NixOS/nixpkgs/pull/202692
    ]);
  };
}
