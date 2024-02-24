{ source
, buildGoModule
, lib
}:

buildGoModule rec {
  inherit (source) pname src;
  version = lib.strings.removePrefix "v" source.version;

  vendorHash = "sha256-6kdf+LwMrIjwC3uZHlMdpEHvonxKfr86PQaMOgzgYOc=";

  doCheck = false;

  CGO_ENABLED = 0;

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${version}"
  ];

  meta = {
    description = "A tiny and feature-rich command line DNS client with support for UDP, TCP, DoT, DoH, DoQ, and ODoH";
    homepage = "https://github.com/natesales/q";
    license = lib.licenses.gpl3Only;
  };
}
