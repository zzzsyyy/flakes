{ source
, lib
, stdenvNoCC
, glib
}:

stdenvNoCC.mkDerivation rec{
  inherit (source) pname src date;
  version = "unstable-${date}";

  nativeBuildInputs = [ glib ];

  buildPhase = ''
    runHook preBuild
    cd quake-mode@repsac-by.github.com
    if [ -d schemas ]; then
      glib-compile-schemas --strict schemas
    fi
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/gnome-shell/extensions
    cp -r . "$out/share/gnome-shell/extensions/quake-mode@repsac-by.github.com"
    runHook postInstall
  '';

  meta = with lib; {
    description = "GNOME Shell extension adds support quake-mode for any application";
    homepage = "https://github.com/repsac-by/gnome-shell-extension-quake-mode";
    license = licenses.mit;
  };
}
