{ pkgs
, config
, lib
, ...
}: {
  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
      maple-mono
      wqy_zenhei
      my.lxgw-wenkai-screen
      my.plangothic
      my.my-fonts
      my.iosevka-zt
    ];
    fontconfig = {
      localConf = builtins.readFile (./fontconfig.conf);
    };
  };
}
