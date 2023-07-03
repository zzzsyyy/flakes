[
  (final: prev: {
    #@TODO https://github.com/NixOS/nixpkgs/pull/241146
    transmission = prev.transmission.overrideAttrs (old: {
      patches = [ ];
      nativeBuildInputs = old.nativeBuildInputs ++ [ prev.python3 ];
      src = prev.fetchFromGitHub {
        owner = "transmission";
        repo = "transmission";
        rev = "4.0.3";
        hash = "sha256-P7omd49xLmReo9Zrg0liO1msUVzCa5CxH7PGmH4oPzg=";
        fetchSubmodules = true;
      };
    });
  })
  # (final: prev: {
  #   libjxl-with-plugin = prev.libjxl.overrideAttrs (old: {
  #     cmakeFlags = old.cmakeFlags ++ [ "-DJPEGXL_ENABLE_PLUGINS=ON" ];
  #     doCheck = false;
  #     buildInputs = old.buildInputs ++ [ prev.gdk-pixbuf ];
  #   });
  # })
]
