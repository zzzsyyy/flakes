{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "flaca";
  version = "2.2.1";

  src = fetchFromGitHub {
    owner = "Blobfolio";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-RXMqPpQM2h6EtIIH8Ix31euC7zK3v2QohZqouNlK7rM=";
  };

  cargoPatches = [ ./cargo-lock.patch ];
  cargoHash = "sha256-z8nqpaSz5dZuoDJUgX1n+6gwFYsS42xwgCn7RnzBXbw=";

  meta = with lib; {
    description = "A CLI tool for x86-64 Linux machines that simplifies the task of maximally, losslessly compressing JPEG and PNG images for use in production web environments";
    homepage = "https://github.com/Blobfolio/flaca";
    license = licenses.wtfpl;
  };
}
