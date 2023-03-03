{ stdenvNoCC
, fetchFromGitHub
}:

stdenvNoCC.mkDerivation rec {
  pname = "firefox-gnome-theme";
  version = "20230218";

  src = fetchFromGitHub {
    repo = "firefox-gnome-theme";
    owner = "rafaelmardojai";
    rev = "0d1349acdfe006dfd94cfa3bae58151450ebe844";
    hash = "sha256-mqRF41HJkUn2zdnDuG2K2repBRt3SeleVVkHxsUu6no=";
  };

  dontConfigure = true;
  dontBuild = true;
  doCheck = false;

  installPhase = ''
    mkdir -p $out/share/firefox-gnome-theme
    cp -r theme configuration userChrome.css userContent.css $out/share/firefox-gnome-theme
  '';
}
