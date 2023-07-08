{ configs
, pkgs
, ...
}:
#@TODO 
{
  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = [
      (pkgs.ibus-engines.rime.override {
        librime = (pkgs.librime.overrideAttrs (old: {
          buildInputs = old.buildInputs ++ [ pkgs.lua5_4 ];
        })).override {
          plugins = with pkgs.my; [ librime-lua librime-octagram ];
        };
      })
    ];
    # ibus.engines = with pkgs.ibus-engines; [ rime ];
  };
}
