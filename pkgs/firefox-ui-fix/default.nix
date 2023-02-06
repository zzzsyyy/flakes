{ stdenvNoCC
, fetchFromGitHub
  # ,  lib  ## lib.fakeSha256
}:

stdenvNoCC.mkDerivation rec {
  pname = "firefox-ui-fix";
  version = "20230204";

  src = fetchFromGitHub {
    repo = "Firefox-UI-Fix";
    owner = "black7375";
    rev = "482b52254060acbf27b857f602d13fb192c99d18";
    hash = "sha256-xQeLA0N5EYrefX6Fnbz2gWkiXESHSg6F5xdxygHRQj4=";
  };

  dontConfigure = true;
  dontBuild = true;
  doCheck = false;

  installPhase = ''
    mkdir -p $out/share/firefox-ui-fix
    cp -r css icons user.js userChrome.css userContent.css $out/share/firefox-ui-fix
  '';
}
