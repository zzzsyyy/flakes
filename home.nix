{pkgs, ... }: {
  imports = [
    ./programs
#    ./services
  ];

  gtk = {
    enable = true;
    theme = {
      package = pkgs.materia-theme;
      name = "Materia";
    };
    iconTheme = {
      package = pkgs.numix-icon-theme-circle;
      name = "Numix-Circle";
    };
  };
  qt = {
    enable = true;
    platformTheme = "gtk";
  };
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.nur.repos.ambroisie.vimix-cursors;
    name = "Vimix-white-cursors";
    size = 42;
  };
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    calibre
    tree
    qbittorrent
    firefox-devedition-bin
    obs-studio
    nur.repos.linyinfeng.icalingua-plus-plus
    nur.repos.linyinfeng.wemeet
    screenkey
    #dev
    julia-bin
  ];
  home.stateVersion = "22.05";
}
