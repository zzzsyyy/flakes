{pkgs, ... }: 
{
  imports = [
    ./programs
#    ./services
  ];

  gtk = {
    enable = true;
    theme = {
      package = pkgs.orchis-theme;
      name = "Orchis";
    };
    iconTheme = {
      package = pkgs.qogir-icon-theme;
      name = "Qogir";
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
