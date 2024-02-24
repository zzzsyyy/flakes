{ source
, lib
, stdenv
, dpkg
, wrapGAppsHook
, autoPatchelfHook
, openssl
, webkitgtk
, udev
, libayatana-appindicator
, tree
}:

stdenv.mkDerivation {
  inherit (source) pname src version;

  nativeBuildInputs = [
    dpkg
    wrapGAppsHook
    autoPatchelfHook
  ];

  buildInputs = [
    openssl
    webkitgtk
    stdenv.cc.cc
    tree
  ];

  runtimeDependencies = [
    (lib.getLib udev)
    libayatana-appindicator
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mv usr/* $out

    runHook postInstall
  '';

  meta = with lib; {
    description = "Continuation of Clash Verge - A Clash Meta GUI based on Tauri (Windows, MacOS, Linux)";
    homepage = "https://github.com/clash-verge-rev/clash-verge-rev";
    platforms = [ "x86_64-linux" ];
    license = licenses.gpl3Plus;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    mainProgram = "clash-verge";
  };
}
