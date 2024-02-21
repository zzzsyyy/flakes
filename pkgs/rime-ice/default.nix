{ source
, lib
, stdenvNoCC
, enableUnihan ? false
}:

stdenvNoCC.mkDerivation rec {
  inherit (source) pname src date;
  version = "unstable-${date}";

  installPhase = ''
    mkdir -p $out/share/rime-data

    install -Dm644 *.{schema,dict}.yaml $out/share/rime-data
    install -Dm644 *.lua                 $out/share/rime-data
    install -Dm644 symbols*.yaml         $out/share/rime-data
    install -Dm644 default.yaml          $out/share/rime-data
    
    ${lib.optionalString enableUnihan ''
      sed -e '9s/^ *# /  /' -i rime_ice.dict.yaml
    ''}
    sed -e '41s/^/# /' -e '43s/^ *# /    /' -i radical_pinyin.schema.yaml
    
    mv cn_dicts en_dicts $out/share/rime-data
    mv opencc lua        $out/share/rime-data
  '';

  meta = with lib; {
    description = "Rime pinyin dict from iDvel";
    homepage = "https://github.com/iDvel/rime-ice";
    license = licenses.gpl3Plus;
  };
}
