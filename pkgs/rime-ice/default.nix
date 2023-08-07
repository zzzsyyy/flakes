{ lib
, stdenvNoCC
, fetchFromGitHub
, enableUnihan ? false
}:

stdenvNoCC.mkDerivation rec {
  pname = "rime-ice";
  version = "unstable-2023-08-07";

  src = fetchFromGitHub {
    owner = "iDvel";
    repo = pname;
    rev = "4b6659a33a4bddd4ba280ef269438e6b9ccb9965";
    hash = "sha256-EiKULMPvNR9C68sKWLLF+qjq/EtmSwEBVuf5KTErKqs=";
  };

  installPhase = ''
    mkdir -p $out/share/rime-data
    ${lib.optionalString enableUnihan ''
      sed -e '9s/^ *# /  /' -i rime_ice.dict.yaml
    ''}
    mv double_pinyin_flypy.schema.yaml rime_ice.schema.yaml \
      liangfen.dict.yaml liangfen.schema.yaml \
      melt_eng.dict.yaml melt_eng.schema.yaml \
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
    homepage = "https://github.com/iDvel/rime-ice";
    license = licenses.gpl3Plus;
  };
}
