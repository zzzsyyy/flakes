{ lib
, stdenvNoCC
, fetchFromGitHub
}:

stdenvNoCC.mkDerivation rec {
  pname = "firefox-gnome-theme";
  version = "115";

  src = fetchFromGitHub {
    repo = pname;
    owner = "rafaelmardojai";
    rev = "v${version}";
    hash = "sha256-YuvNdDX1UAAJpoVMMUnmC20aRuIB5OuzZfaDHUEKFBQ=";
  };

  dontConfigure = true;
  dontBuild = true;
  doCheck = false;

  installPhase = ''
    mkdir -p $out/share/firefox-gnome-theme
    cp -r theme configuration userChrome.css userContent.css $_
  '';

  meta = with lib; {
    description = "A GNOME theme for Firefox";
    homepage = "https://github.com/rafaelmardojai/firefox-gnome-theme";
    license = licenses.unlicense;
  };
}
