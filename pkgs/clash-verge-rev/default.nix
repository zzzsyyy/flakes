{ lib
, stdenv
, fetchurl
, dpkg
, wrapGAppsHook
, autoPatchelfHook
, openssl
, webkitgtk
, udev
, libayatana-appindicator
, tree
}:

stdenv.mkDerivation rec {
  pname = "clash-verge-rev";
  version = "1.5.2";

  src = fetchurl {
    url = "https://github.com/clash-verge-rev/clash-verge-rev/releases/download/v${version}/clash-verge_${version}_amd64.deb";
    hash = "sha256-MUj+9xo20yn6tzOguJkq5KPKxHZVax2ryHERIr+6dtA=";
  };

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

  # postFixup = ''
  # ln -s ${lib.getExe clash-meta} $out/bin/clash-meta
  # '';

  meta = with lib; {
    description = "Continuation of Clash Verge - A Clash Meta GUI based on Tauri (Windows, MacOS, Linux)";
    homepage = "https://github.com/clash-verge-rev/clash-verge-rev";
    platforms = [ "x86_64-linux" ];
    license = licenses.gpl3Plus;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    mainProgram = "clash-verge";
  };
}
