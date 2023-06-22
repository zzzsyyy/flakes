{ pkgs, config, lib, ... }: {
  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      plangothic
      my-fonts
      noto-fonts-emoji
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
      maple-mono
      wqy_zenhei
      lxgw-wenkai-screen
      iosevka-zt
    ];
    fontconfig = {
      localConf = builtins.readFile (./fontconfig.conf);
    };
  };
}
