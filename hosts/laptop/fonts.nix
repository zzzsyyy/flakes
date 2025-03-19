{ pkgs, lib, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      nerd-fonts.symbols-only
      maple-mono
      wqy_zenhei
      my.lxgw-wenkai-screen
      my.plangothic
      my.my-fonts
      my.iosevka-zt
    ];
    #fontconfig = {
    #  localConf = builtins.readFile (./fontconfig.conf);
    #};
    fontconfig = {
      subpixel.rgba = "none";
      antialias = true;
      hinting.enable = false;
      defaultFonts = lib.mkForce {
        serif = [
          "Noto Serif"
          "Noto Serif CJK SC"
          "Noto Serif CJK TC"
          "Noto Serif CJK JP"
        ];
        monospace = [
          "Iosevka ZT Extended"
          "Noto Sans Mono CJK SC"
          "Symbols Nerd Font"
          "Maple Mono"
        ];
        sansSerif = [
          "Noto Sans CJK SC"
          "Noto Sans CJK TC"
          "Noto Sans CJK JP"
        ];
        emoji = [
          "noto-fonts-emoji"
        ];
      };
    };
  };
}
