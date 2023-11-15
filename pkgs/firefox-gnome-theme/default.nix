{ source
, lib
, stdenvNoCC
}:

stdenvNoCC.mkDerivation {
  inherit (source) pname src;

  version = lib.strings.removePrefix "v" source.version;

  dontConfigure = true;
  dontBuild = true;
  doCheck = false;

  installPhase = ''
    mkdir -p $out/share/firefox-theme
    cp -r theme configuration userChrome.css userContent.css $_
  '';

  meta = with lib; {
    description = "A GNOME theme for Firefox";
    homepage = "https://github.com/rafaelmardojai/firefox-gnome-theme";
    license = licenses.unlicense;
  };
}
