{ pkgs, config, lib, ... }: {
  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      plangothic
      #my-fonts
      noto-fonts-emoji
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
      (iosevka-bin.override { variant = "sgr-iosevka-term-ss05"; })
      maple-mono
      wqy_zenhei
      ((iosevka.override {
        privateBuildPlan = {
          family = "Iosevka ZT";
          spacing = "term";
          serifs = "sans";
          no-cv-ss = false;
          export-glyph-names = true;
          variants = {
            inherits = "ss05";
            design = {
              a = "single-storey-tailed";
              i = "serifed-flat-tailed";
              zero = "oval-tall-slashed";
              three = "flat-top";
              ampersand = "upper-open";
              percent = "rings-continuous-slash-also-connected";
            };
          };
          ligations.inherits = "dlig";
        };
        set = "zt";
      }).overrideAttrs ( old: {
          preBuild = ''
            export NIX_BUILD_CORES=4;
          '';
        }))
    ];
    fontconfig = {
      localConf = builtins.readFile (./fontconfig.conf);
    };
  };
}
