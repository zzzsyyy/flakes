{pkgs, ... }: 
{
  imports = [
#    ./programs
#    ./services
  ];

  gtk = {
    enable = true;
    theme = {
      package = pkgs.graphite-gtk-theme;
      name = "Graphite";
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
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = false;
    package = pkgs.nur.repos.ambroisie.vimix-cursors;
    name = "Vimix-white-cursors";
    size = 42;
  };
  programs.home-manager.enable = true;
  #services.espanso.enable = true;
  home.packages = with pkgs; [
    calibre
    #tree
    #qbittorrent
    #obs-studio
    #nur.repos.linyinfeng.icalingua-plus-plus
    #nur.repos.linyinfeng.wemeet
    #screenkey
    #dev
    julia-bin
  ];
  home.stateVersion = "23.05";
}
