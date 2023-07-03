let 
  userChrome = "${pkgs.my.firefox-gnome-theme}/share/firefox-gnome-theme/userChrome.css";
in

''
@import "${userChrome}";
@import usi(./custom/fix_gnome_bookmark.css);
@import uri(./custom/sidebery_dyn.css);
''
