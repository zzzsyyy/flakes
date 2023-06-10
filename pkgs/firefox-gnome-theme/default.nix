{ stdenvNoCC
, fetchFromGitHub
}:

stdenvNoCC.mkDerivation rec {
  pname = "firefox-gnome-theme";
  version = "20230610";

  src = fetchFromGitHub {
    repo = "firefox-gnome-theme";
    owner = "rafaelmardojai";
    rev = "25a9ab399e0c3c21d28d25d428871d7ed8a3719a";
    hash = "sha256-Cqwqwu2KqHJOwh3sldU59+kz+gQM2f2Z9ZbX6TjzUOg=";
  };

  dontConfigure = true;
  dontBuild = true;
  doCheck = false;

  installPhase = ''
    mkdir -p $out/share/firefox-gnome-theme
    cp -r theme configuration userChrome.css userContent.css $out/share/firefox-gnome-theme
  '';
}
