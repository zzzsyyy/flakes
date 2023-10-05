{ lib
, stdenvNoCC
, fetchFromGitHub
, enableUnihan ? false
}:

stdenvNoCC.mkDerivation rec {
  pname = "rime-ice";
  version = "unstable-2023-09-29";

  src = fetchFromGitHub {
    owner = "iDvel";
    repo = pname;
    rev = "fab529d43bdf21572b260d77da8a02dba523f494";
    hash = "sha256-hsS4Jso9gFk2jaiNkSCl40Nyf7XneOKv+QSC2qK/UX4=";
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
