{ pkgs
, ...
}:
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
        rimeDataPkgs = [
          (pkgs.my.rime-ice.override {
            enableUnihan = true;
          })
        ];
      })
    ];
    # ibus.engines = with pkgs.ibus-engines; [ rime ];
  };
}
