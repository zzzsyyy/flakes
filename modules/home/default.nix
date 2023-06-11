{ pkgs, ... }:

{
  imports = [
    ./programs
    ./pkgs.nix
  ];

  gtk = {
    enable = true;
    #theme = {
    #  package = pkgs.adw-gtk3;
    #  name = "Adw-gtk3";
    #};
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus";
    };
  };
  qt = {
    enable = true;
    platformTheme = "gtk";
  };
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    gtk.enable = true;
    x11.enable = true;
    size = 24;
  };
  xdg.userDirs.enable = true;
  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
}
