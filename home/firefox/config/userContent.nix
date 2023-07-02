let 
  userContent = "${pkgs.my.firefox-gnome-theme}/share/firefox-gnome-theme/userContent.css";
in

''
@import "${userContent}";
@import uri(./custom/userContent.css);
''
