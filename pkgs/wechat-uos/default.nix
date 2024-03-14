{ stdenvNoCC
, stdenv
, lib
, fetchurl
, requireFile
, dpkg
, nss
, nspr
, xorg
, pango
, zlib
, atkmm
, libdrm
, libxkbcommon
, xcbutilwm
, xcbutilimage
, xcbutilkeysyms
, xcbutilrenderutil
, mesa
, alsa-lib
, wayland
, openssl_1_1
, atk
, at-spi2-atk
, at-spi2-core
, dbus
, cups
, gtk3
, libxml2
, cairo
, freetype
, fontconfig
, vulkan-loader
, gdk-pixbuf
, libexif
, ffmpeg
, pipewire
, libuuid
, expat
, bzip2
, glib
, systemd
, libva
, libGL
, libnotify
, buildFHSEnv
, writeShellScript
}:
let
  wechat-uos-env = stdenvNoCC.mkDerivation {
    meta.priority = 1;
    name = "wechat-uos-env";
    buildCommand = ''
      mkdir -p $out/etc
      mkdir -p $out/lib/license
      mkdir -p $out/usr/bin
      mkdir -p $out/usr/share
      mkdir -p $out/opt
      mkdir -p $out/var

      ln -s ${wechat}/opt/* $out/opt/
      ln -s ${wechat}/usr/lib/wechat-uos/license/etc/os-release  $out/etc/os-release
      ln -s ${wechat}/usr/lib/wechat-uos/license/etc/lsb-release  $out/etc/lsb-release
      ln -s ${wechat}/usr/lib/wechat-uos/license/var/*  $out/var/
      ln -s ${wechat}/usr/lib/wechat-uos/license/libuosdevicea.so $out/lib/license/
    '';
    preferLocalBuild = true;
  };

  wechat-uos-runtime = with xorg; [
    stdenv.cc.cc
    stdenv.cc.libc
    pango
    zlib
    xcbutilwm
    xcbutilimage
    xcbutilkeysyms
    xcbutilrenderutil
    libX11
    libXt
    libXext
    libSM
    libICE
    libxcb
    libxkbcommon
    libxshmfence
    libXi
    libXft
    libXcursor
    libXfixes
    libXScrnSaver
    libXcomposite
    libXdamage
    libXtst
    libXrandr
    libnotify
    atk
    atkmm
    cairo
    at-spi2-atk
    at-spi2-core
    alsa-lib
    dbus
    cups
    gtk3
    gdk-pixbuf
    libexif
    ffmpeg
    systemd
    libva
    freetype
    fontconfig
    libXrender
    libuuid
    expat
    glib
    nss
    nspr
    libGL
    libxml2
    pango
    libdrm
    mesa
    vulkan-loader
    wayland
    pipewire
    openssl_1_1
    bzip2
  ];

  wechat = stdenvNoCC.mkDerivation
    rec {
      pname = "wechat-uos";
      version = "1.0.0.236";

      src = {
        x86_64-linux = fetchurl {
          url = "https://pro-store-packages.uniontech.com/appstore/pool/appstore/c/com.tencent.wechat/com.tencent.wechat_${version}_amd64.deb";
          hash = "sha256-lYwnBdOzdHD3Jyc3N51e19OAnPUfmprJT4HLvJNGVBo=";
        };
        aarch64-linux = fetchurl {
          url = "https://pro-store-packages.uniontech.com/appstore/pool/appstore/c/com.tencent.wechat/com.tencent.wechat_${version}_arm64.deb";
          hash = "sha256-DFfYUYTf9nPU9Qz6DCmArAExbBLj5aK+7SwqPDqVSGM=";
        };
      }.${stdenv.system} or (throw "${pname}-${version}: ${stdenv.system} is unsupported.");

      # Don't blame about this. WeChat requires some binary from here to work properly
      uosSrc = {
        x86_64-linux = fetchurl {
          url = "https://home-store-packages.uniontech.com/appstore/pool/appstore/c/com.tencent.weixin/com.tencent.weixin_2.1.5_amd64.deb";
          hash = "sha256-vVN7w+oPXNTMJ/g1Rpw/AVLIytMXI+gLieNuddyyIYE=";
        };
        aarch64-linux = fetchurl {
          url = "https://home-store-packages.uniontech.com/appstore/pool/appstore/c/com.tencent.weixin/com.tencent.weixin_2.1.5_arm64.deb";
          hash = "sha256-XvGFPYJlsYPqRyDycrBGzQdXn/5Da1AJP5LgRVY1pzI=";
        };
      }.${stdenv.system} or (throw "${pname}-${version}: ${stdenv.system} is unsupported.");

      uosLicense = requireFile {
        name = "license.tar.gz";
        url = "https://www.uniontech.com";
        sha256 = "53760079c1a5b58f2fa3d5effe1ed35239590b288841d812229ef4e55b2dbd69";
      };

      nativeBuildInputs = [ dpkg ];

      unpackPhase = ''
        runHook preUnpack

        dpkg -x $src ./wechat-uos
        dpkg -x $uosSrc ./wechat-uos-old-source

        tar -xvf $uosLicense

        runHook postUnpack
      '';

      installPhase = ''
        runHook preInstall
        mkdir -p $out

        cp -r wechat-uos/* $out

        mkdir -pv $out/usr/lib/wechat-uos/license
        cp -r license/* $out/usr/lib/wechat-uos/license
        cp -r wechat-uos-old-source/usr/lib/license/libuosdevicea.so $out/usr/lib/wechat-uos/license/

        runHook postInstall
      '';

      meta = with lib; {
        description = "Messaging app";
        homepage = "https://weixin.qq.com/";
        license = licenses.unfree;
        platforms = [ "x86_64-linux" "aarch64-linux" ];
        sourceProvenance = with sourceTypes; [ binaryNativeCode ];
        maintainers = with maintainers; [ pokon548 ];
        mainProgram = "wechat-uos";
      };
    };
in
buildFHSEnv {
  inherit (wechat) name meta;
  runScript = writeShellScript "wechat-uos-launcher" ''
    export QT_QPA_PLATFORM=xcb
    export LD_LIBRARY_PATH=${lib.makeLibraryPath wechat-uos-runtime}
    ${wechat.outPath}/opt/apps/com.tencent.wechat/files/wechat
  '';
  extraInstallCommands = ''
    mkdir -p $out/share/applications
    mkdir -p $out/share/icons
    cp -r ${wechat.outPath}/opt/apps/com.tencent.wechat/entries/applications/com.tencent.wechat.desktop $out/share/applications
    cp -r ${wechat.outPath}/opt/apps/com.tencent.wechat/entries/icons/* $out/share/icons/

    substituteInPlace $out/share/applications/com.tencent.wechat.desktop \
      --replace-quiet 'Exec=/usr/bin/wechat' "Exec=$out/bin/wechat-uos --"
  '';
  targetPkgs = pkgs: [ wechat-uos-env ];

  extraOutputsToInstall = [ "usr" "var/lib/uos" "var/uos" "etc" ];
}
