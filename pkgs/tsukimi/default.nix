{
  lib,
  mpv,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  openssl,
  gst_all_1,
}:
rustPlatform.buildRustPackage rec {
  pname = "tsukimi";
  version = "0.6.6";
  src = fetchFromGitHub {
    owner = "tsukinaha";
    repo = "tsukimi";
    rev = "v${version}";
    hash = "sha256-ZjrL32T5kfnlV9Cb7M58z9QqUiOaIcFIdbkvrnR0OR0=";
  };

  cargoHash = "sha256-z2xSozENAPyyfiDtUpOWUXH+RvhL/qjd8njl7WL3y0E=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
    openssl
    mpv
    gst_all_1.gst-plugins-base
    gst_all_1.gstreamer
  ];

  meta = with lib; {
    description = "Beautiful";
    homepage = "https://github.com/rust-motd/rust-motd";
    changelog = "https://github.com/rust-motd/rust-motd/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ zzzsy ];
    mainProgram = "tsukimi";
  };
}
