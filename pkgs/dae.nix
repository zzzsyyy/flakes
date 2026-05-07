{
  lib,
  clang,
  fetchFromGitHub,
  buildGoLatestModule,
}:

buildGoLatestModule (finalAttrs: {
  pname = "dae";
  version = "2.0.0rc1-unstable-2026-05-06";

  src = fetchFromGitHub {
    owner = "daeuniverse";
    repo = "dae";
    rev = "c7e02968f8baa425798b05dd4ab4142e3c20f568";
    hash = "sha256-61yNOhRPSH5+Y4Y7G1hi3OHxkTBa4FpaA5JRUYIQETE=";
    fetchSubmodules = true;
  };

  vendorHash = "sha256-Bf2OgF3+dOC2LiD/2Y+g+tfc07ZctdRH/BAUO23fX6k=";

  proxyVendor = true;

  nativeBuildInputs = [ clang ];

  hardeningDisable = [ "zerocallusedregs" ];

  env.VERSION = finalAttrs.version;

  buildPhase = ''
    make CFLAGS="-D__REMOVE_BPF_PRINTK -fno-stack-protector -Wno-unused-command-line-argument" \
    NOSTRIP=y \
    OUTPUT=$out/bin/dae
  '';

  # network required
  doCheck = false;

  postInstall = ''
    install -Dm444 install/dae.service $out/lib/systemd/system/dae.service
    substituteInPlace $out/lib/systemd/system/dae.service \
      --replace /usr/bin/dae $out/bin/dae
  '';

  meta = with lib; {
    description = "A Linux high-performance transparent proxy solution based on eBPF";
    homepage = "https://github.com/daeuniverse/dae";
    license = licenses.agpl3Only;
    platforms = platforms.linux;
    mainProgram = "dae";
  };
})
