{ lib
, stdenvNoCC
, fetchFromGitHub
, enableUnihan ? false
}:

stdenvNoCC.mkDerivation rec {
  pname = "rime-ice";
  version = "unstable-2023-07-08";

  src = fetchFromGitHub {
    owner = "iDvel";
    repo = pname;
    rev = "98e2368456e9e4cda3adf9812891e5dd4b2edc55";
    hash = "sha256-3J6i2y05r5B616eI+myyoxhX6h55MKlVdNdnTHneHCE=";
  };

  installPhase = ''
    mkdir -p $out/share/rime-data
    ${lib.optionalString enableUnihan ''
      sed -e '9s/^ *# /  /' -i rime_ice.dict.yaml
    ''}
    mv double_pinyin_flypy.schema.yaml rime_ice.schema.yaml \
      liangfen.dict.yaml liangfen.schema.yaml \
      melt_eng.dict.yaml melt_eng.schema.yaml \
      zh-hans-t-essay-bgw.gram \
      rime_ice.dict.yaml \
      symbols_caps_v.yaml symbols_v.yaml \
      cn_dicts/ en_dicts/ \
      opencc lua rime.lua \
      custom_phrase.txt \
      default.yaml \
      $out/share/rime-data
  '';

  meta = with lib; {
    description = "Rime pinyin dict from iDvel";
    license = licenses.gpl3Plus;
    homepage = "https://github.com/iDvel/rime-ice";
  };
}
