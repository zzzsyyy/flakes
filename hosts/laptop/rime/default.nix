{ pkgs
, ...
}:
{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = [
      (pkgs.fcitx5-rime.override {
        librime = (pkgs.librime.overrideAttrs (old: {
          buildInputs = old.buildInputs ++ [ pkgs.lua5_4 ];
        })).override {
          plugins = with pkgs.my; [ librime-lua ];
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
