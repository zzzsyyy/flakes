{ stdenv
, lib
, fetchFromGitHub
, brotli
, cmake
, giflib
, gperftools
, gtest
, libhwy
, libjpeg
, libpng
, libwebp
, gdk-pixbuf
, openexr_3
, pkg-config
, makeWrapper
, zlib
, asciidoc
, graphviz
, doxygen
, python3
, lcms2
}:

let
  inherit (gdk-pixbuf) moduleDir;
  loadersPath = "${gdk-pixbuf.binaryDir}/jxl-loaders.cache";
in

stdenv.mkDerivation rec {
  pname = "libjxl";
  version = "0.10.0";

  outputs = [ "out" "bin" "dev" ];

  src = fetchFromGitHub {
    owner = "libjxl";
    repo = "libjxl";
    rev = "v${version}";
    hash = "sha256-z383i6MM5WHFVv7ozrTJA1/OJ4yI2vFtA7wnRIOSKDs=";
    # There are various submodules in `third_party/`.
    fetchSubmodules = true;
  };

  strictDeps = true;

  nativeBuildInputs = [
    cmake
    pkg-config
    gdk-pixbuf
    makeWrapper
    asciidoc
    doxygen
    python3
  ];

  depsBuildBuild = [
    graphviz
  ];

  # Functionality not currently provided by this package
  # that the cmake build can apparently use:
  #     OpenGL/GLUT (for Examples -> comparison with sjpeg)
  #     viewer (see `cmakeFlags`)
  #     plugins like for GDK and GIMP (see `cmakeFlags`)

  # Vendored libraries:
  # `libjxl` currently vendors many libraries as git submodules that they
  # might patch often (e.g. test/gmock, see
  # https://github.com/NixOS/nixpkgs/pull/103160#discussion_r519487734).
  # When it has stabilised in the future, we may want to tell the build
  # to use use nixpkgs system libraries.

  # As of writing, libjxl does not point out all its dependencies
  # conclusively in its README or otherwise; they can best be determined
  # by checking the CMake output for "Could NOT find".
  buildInputs = [
    lcms2
    giflib
    gperftools # provides `libtcmalloc`
    gtest
    libjpeg
    libpng
    libwebp
    gdk-pixbuf
    openexr_3
    zlib
  ];

  propagatedBuildInputs = [
    brotli
    libhwy
  ];

  cmakeFlags = [
    # For C dependencies like brotli, which are dynamically linked,
    # we want to use the system libraries, so that we don't have to care about
    # installing their .so files generated by this build.
    # The other C++ dependencies are statically linked in, so there
    # using the vendorered ones is easier.
    "-DJPEGXL_FORCE_SYSTEM_BROTLI=ON"

    # Use our version of highway, though it is still statically linked in
    "-DJPEGXL_FORCE_SYSTEM_HWY=ON"

    # Use our version of gtest
    "-DJPEGXL_FORCE_SYSTEM_GTEST=ON"

    # TODO: Update this package to enable this (overridably via an option):
    # Viewer tools for evaluation.
    # "-DJPEGXL_ENABLE_VIEWERS=ON"

    # TODO: Update this package to enable this (overridably via an option):
    # Enable plugins, such as:
    # * the `gdk-pixbuf` one, which allows applications like `eog` to load jpeg-xl files
    # * the `gimp` one, which allows GIMP to load jpeg-xl files
    "-DJPEGXL_ENABLE_PLUGINS=ON"
  ] ++ lib.optionals stdenv.hostPlatform.isStatic [
    "-DJPEGXL_STATIC=ON"
  ] ++ lib.optionals stdenv.hostPlatform.isAarch32 [
    "-DJPEGXL_FORCE_NEON=ON"
  ];

  postPatch = ''
    substituteInPlace plugins/gdk-pixbuf/jxl.thumbnailer \
      --replace '/usr/bin/gdk-pixbuf-thumbnailer' "$out/libexec/gdk-pixbuf-thumbnailer-jxl"
  '';

  postInstall = ''
    GDK_PIXBUF_MODULEDIR="$out/${moduleDir}" \
    GDK_PIXBUF_MODULE_FILE="$out/${loadersPath}" \
    gdk-pixbuf-query-loaders --update-cache
    mkdir -p "$out/bin"
    makeWrapper ${gdk-pixbuf}/bin/gdk-pixbuf-thumbnailer "$out/libexec/gdk-pixbuf-thumbnailer-jxl" \
      --set GDK_PIXBUF_MODULE_FILE "$out/${loadersPath}" \
  '';

  CXXFLAGS = lib.optionalString stdenv.hostPlatform.isAarch32 "-mfp16-format=ieee";

  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/libjxl/libjxl";
    description = "JPEG XL image format reference implementation.";
    license = licenses.bsd3;
    maintainers = with maintainers; [ nh2 ];
    platforms = platforms.all;
  };
}
