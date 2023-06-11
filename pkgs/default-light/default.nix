{ lib
, stdenvNoCC
, fetchFromGitLab
, sassc
}:

stdenvNoCC.mkDerivation rec {
  pname = "gnome-shell-theme-default-light";
  version = "gnome-44-20230515";

  src = fetchFromGitLab {
    domain = "gitlab.gnome.org";
    owner = "eeshugerman";
    repo = pname;
    rev = "5af1c43690bf2580aeec7c2245aebc4ad9a02eed";
    hash = "sha256-GlqMPvM1+hhLAnqFKcvSSnWzqMjcv85+V+aI/SkYBx0=";
  };

  nativeBuildInputs = [ sassc ];

  installPhase = ''
    mkdir -p $out/share/themes/Default-light/gnome-shell
    cp gnome-shell.css $out/share/themes/Default-light/gnome-shell
  '';
}
