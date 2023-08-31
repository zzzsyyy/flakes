[
  (final: prev: {
    megasync = prev.megasync.overrideAttrs (old: {
      buildInputs = old.buildInputs ++ [ prev.gnome.nautilus ];
      postPatch = final.lib.strings.concatStrings [
        old.postPatch
        ''
          sed -i '/SUBDIRS += MEGAShellExtThunar/ s/^/# /' src/MEGA.pro
          sed -i '/SUBDIRS += MEGAShellExtDolphin/ s/^/# /' src/MEGA.pro
          sed -i '/SUBDIRS += MEGAShellExtNemo/ s/^/# /' src/MEGA.pro
          substituteInPlace src/MEGAShellExtNautilus/MEGAShellExtNautilus.pro \
            --replace \$\$\{EXTENSIONS_PATH\} /lib/nautilus/extensions-4 \
        ''
      ];
      preBuild = ''
        qmake CONFIG+="with_ext" MEGA.pro
        pushd MEGAShellExtNautilus
          DESKTOP_DESTDIR="$out" qmake -o Makefile MEGAShellExtNautilus.pro
        popd
        pushd MEGASync
          lrelease MEGASync.pro
          DESKTOP_DESTDIR="$out" qmake PREFIX="$out" -o Makefile MEGASync.pro CONFIG+=release
        popd
      '';
    });
  })
]
