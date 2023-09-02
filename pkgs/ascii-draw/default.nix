{ lib
, python3
, fetchFromGitHub
, cmake
, meson
, ninja
, glib
, gettext
, pkg-config
, desktop-file-utils
, appstream-glib
, gobject-introspection
, wrapGAppsHook4
, gtk4
, libadwaita
}:

python3.pkgs.buildPythonApplication rec {
  pname = "ascii-draw";
  version = "0.1.8";
  format = "other";

  src = fetchFromGitHub {
    owner = "Nokse22";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-Ai09hGjIJ3zI2w+QwZqoJ26zTlH/GTJIskN8YaKD4nk=";
  };

  nativeBuildInputs = [
    meson
    ninja
    gettext
    pkg-config
    desktop-file-utils
    appstream-glib
    wrapGAppsHook4
    cmake
    gobject-introspection
  ];

  buildInputs = [
    gtk4
    libadwaita
  ];

  propagatedBuildInputs = with python3.pkgs; [
    pygobject3
    pyfiglet
    setuptools
    emoji
  ];

  dontWrapGApps = true;
  preFixup = ''
    makeWrapperArgs+=("''${gappsWrapperArgs[@]}")
  '';

  meta = with lib; {
    description = "An app to draw diagrams or anything using only ASCII ";
    homepage = "https://github.com/Nokse22/ascii-draw";
    license = licenses.gpl3Plus;
  };
}
