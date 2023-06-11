[
    (final: prev: {
    # Until nixpkgs#215316 is resolved
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
]
