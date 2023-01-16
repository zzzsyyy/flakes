{ lib, stdenvNoCC, fetchFromGitHub, gitUpdater, gnome-shell, gnome-themes-extra, gtk-engine-murrine, sassc, jdupes
, theme ? [] # default: grey
, color ? [] # default: all
, size ? [] # default: stardard
, gdm ? false
, libadwaita ? false
, tweaks ? []
}: 

let
  pname = "graphite-gtk-theme";

in

lib.checkListOfEnum "${pname}: theme variants" [ "default" "purple" "pink" "red" "orange" "yellow" "green" "teal" "blue" "all" ] theme
lib.checkListOfEnum "${pname}: color variants" [ "standard" "light" "dark" ] color
lib.checkListOfEnum "${pname}: size variants" [ "standard" "compact" ] size
lib.checkListOfEnum "${pname}: tweaks" [ "nord" "black" "darker" "rimless" "normal" ] tweaks

stdenvNoCC.mkDerivation
rec{
  inherit pname;
  version = "d1c8ec940964582f934feaff1346e73084ab4ddd";

  src = fetchFromGitHub {
    owner = "vinceliuice";
    repo = pname;
    rev = version;
    hash = "sha256-VOr3yojvtcR8c27ZTmfl1jhQAZPddgESXMzlYSftX9s=";
  };

  nativeBuildInputs = [
    gnome-shell
    jdupes
    sassc
  ];

  buildInput = [
    gnome-themes-extra
  ];

  propagatedUserEnvPkgs = [
    gtk-engine-murrine
  ];

  postPatch = ''
    patchShebangs ./install.sh
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/themes
    ./install.sh \
      ${lib.optionalString (theme != []) "-t " + builtins.toString theme} \
      ${lib.optionalString (color != []) "-c " + builtins.toString color} \
      ${lib.optionalString (size != []) "-s " + builtins.toString size} \
      ${lib.optionalString (tweaks != []) "--tweaks " + builtins.toString tweaks} \
      -d $out/share/themes

    jdupes --quiet --link-soft --recurse $out/share

    runHook postInstall
  '';

  passthru.updateScript = gitUpdater { };

  meta = with lib; {
    description = "Flat Gtk+ theme based on Elegant Design";
    homepage = "https://github.com/vinceliuice/Graphite-gtk-theme";
    license = licenses.gpl3Only;
    platforms = platforms.unix;
    maintainers = [ maintainers.zzzsy ];
  };
}
