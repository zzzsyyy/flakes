{
    configs
,   pkgs
,   ...
} :

let

librime-lua = pkgs.callPackage (import ../../../pkgs/librime-plugins/librime-lua) {};
librime-octagram = pkgs.callPackage (import ../../../pkgs/librime-plugins/librime-octagram) {};

in

{
    i18n.inputMethod = {
      enabled = "ibus";
      ibus.engines = [(pkgs.ibus-engines.rime.override{
        librime = (pkgs.librime.overrideAttrs (old: {
          buildInputs = old.buildInputs ++ [ pkgs.lua5_4 ]; 
        })).override { 
          plugins = [ librime-lua librime-octagram ]; 
        };
    })];
      # ibus.engines = with pkgs.ibus-engines; [ rime ];
  };
}
