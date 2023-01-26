{  stdenvNoCC
,  fetchFromGitHub
# ,  lib  ## lib.fakeSha256
} :

stdenvNoCC.mkDerivation rec {
    pname = "firefox-ui-fix";
    version = "f1a5fd4357a7ec3d0eb6962a2686543b3a448135";

    src = fetchFromGitHub {
        repo = "Firefox-UI-Fix";
        owner = "black7375";
        rev = version;
        sha256 = "sha256-xQeLA0N5EYrefX6Fnbz2gWkiXESHSg6F5xdxygHRQj4=";
    };

    dontConfigure = true;
    dontBuild = true;
    doCheck = false;

    installPhase = ''
        mkdir -p $out/share/firefox-ui-fix
        cp -r css icons user.js userChrome.css userContent.css $out/share/firefox-ui-fix
    '';
}
