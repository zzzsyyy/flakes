{ pkgs, ... }:

{
  imports = [
    ./programs
    ./pkgs.nix
    ../rime/home.nix
  ];

  gtk = {
    enable = true;
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
  services.megasync = {
    enable = true;
    package = pkgs.symlinkJoin {
      name = "megasync";
      paths = [ pkgs.megasync ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/megasync --prefix QT_SCALE_FACTOR : 1
      '';
    };
  };
  xdg.userDirs.enable = true;
  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
}
