{ stdenv
, lib
, fetchurl
, makeWrapper
, dpkg
  # Dynamic libraries
, alsa-lib
, atk
, cairo
, dbus
, expat
, libGL
, libuuid
, fontconfig
, freetype
, gtk3
, gdk-pixbuf
, glib
, nspr
, nss
, pango
, wayland
, xorg
, libxkbcommon
, zlib
  # Runtime
, coreutils
, pciutils
, procps
, util-linux
, pulseaudioSupport ? true
, libpulseaudio
}:

let
  version = "2.5.361956.0302";
  srcs = {
    x86_64-linux = fetchurl {
      url = "http://downloads.zhumu.me/client/latest/linux/zhumu_${version}_amd64.deb";
      sha256 = "1jblf41d5p7hv3drdsn17m8rb76l6vg696zv3m0lx45jjmkllgvx";
    };
  };

  libs = lib.makeLibraryPath ([
    # $ LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH:$PWD ldd zhumu | grep 'not found'
    alsa-lib
    atk
    cairo
    dbus
    expat
    libGL
    libuuid
    fontconfig
    freetype
    gtk3
    gdk-pixbuf
    glib
    nspr
    nss
    pango
    stdenv.cc.cc
    wayland
    xorg.libX11
    xorg.libxcb
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    libxkbcommon
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    zlib
    xorg.xcbutilimage
    xorg.xcbutilkeysyms
    xorg.libXfixes
    xorg.libXtst
  ] ++ lib.optional (pulseaudioSupport) libpulseaudio);

in
stdenv.mkDerivation rec {
  pname = "zhumu";
  inherit version;

  src = srcs.${stdenv.hostPlatform.system};

  dontUnpack = true;

  nativeBuildInputs = [
    dpkg
    makeWrapper
  ];

  installPhase = ''
    runHook preInstall
    mkdir $out
    dpkg -x $src $out
    chmod 755 $out
    mv $out/usr/* $out/
    runHook postInstall
  '';

  postFixup = ''
    # Desktop File
    substituteInPlace $out/share/applications/Zhumu.desktop \
        --replace "Exec=/usr/bin/zhumu" "Exec=$out/bin/zhumu"
    # LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH:$PWD ldd "$out/opt/zhumu/zhumu" | grep 'not found'
    for i in zopen zhumu ZhumuLauncher; do
      patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $out/opt/zhumu/$i
    done
    # ZhumuLauncher sets LD_LIBRARY_PATH before execing zhumu
    wrapProgram $out/opt/zhumu/zhumu \
      --prefix LD_LIBRARY_PATH ":" ${libs}
    rm $out/bin/zhumu
    # Zhumu expects "zopen" executable (needed for web login) to be present in CWD. Or does it expect
    # everybody runs Zhumu only after cd to Zhumu package directory? Anyway, :facepalm:
    # Clear Qt paths to prevent tripping over "foreign" Qt resources.
    # Clear Qt screen scaling settings to prevent over-scaling.
    makeWrapper $out/opt/zhumu/ZhumuLauncher $out/bin/zhumu \
      --run "cd $out/opt/zhumu" \
      --unset QML2_IMPORT_PATH \
      --unset QT_PLUGIN_PATH \
      --unset QT_SCREEN_SCALE_FACTORS \
      --prefix PATH : ${lib.makeBinPath [ coreutils glib.dev pciutils procps util-linux ]} \
      --prefix LD_LIBRARY_PATH ":" ${libs}
  '';

  # already done
  dontPatchELF = true;

  passthru.updateScript = ./update.sh;

  meta = with lib; {
    homepage = "https://www.zhumu.me";
    description = "Video Conferencing and Web Conferencing Service";
    license = licenses.unfree;
    platforms = builtins.attrNames srcs;
    maintainers = with maintainers; [
      # This derivation was written based on zoom-us, which has the maintainers:
      # danbst tadfisher doronbehar
      {
        email = "mulhaq2005@gmail.com";
        github = "YodaEmbedding";
        githubId = 721196;
        name = "Mateen Ulhaq";
      }
    ];
  };
}
