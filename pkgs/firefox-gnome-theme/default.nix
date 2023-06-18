{ stdenvNoCC
, fetchFromGitHub
}:

stdenvNoCC.mkDerivation rec {
  pname = "firefox-gnome-theme";
  version = "114";

  src = fetchFromGitHub {
    repo = pname;
    owner = "rafaelmardojai";
    rev = "v${version}";
    hash = "sha256-o53fws/jwhLfxiYfTyYpKSGi61d5LHzGgSCkt3DNGRI=";
  };

  dontConfigure = true;
  dontBuild = true;
  doCheck = false;

  installPhase = ''
    mkdir -p $out/share/firefox-gnome-theme
    cp -r theme configuration userChrome.css userContent.css $out/share/firefox-gnome-theme
  '';
}
