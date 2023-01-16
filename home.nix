{pkgs, ... }: 
{
  imports = [
#    ./programs
#    ./services
  ];

  gtk = {
    enable = true;
    theme = {
      package = pkgs.adw-gtk3;
      name = "Adw-gtk3";
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus";
    };
  };
  qt = {
    enable = true;
    platformTheme = "gtk";
  };
  #home.pointerCursor = {
  #  gtk.enable = true;
  #  x11.enable = false;
  #  package = pkgs.nur.repos.ambroisie.vimix-cursors;
  #  name = "Vimix-white-cursors";
  #  size = 42;
  #};
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    calibre
    julia-bin
  ];
  home.stateVersion = "23.05";
}
