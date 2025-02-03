{
  lib,
  stdenv,
  fetchFromGitHub,
  kernel,
}:

stdenv.mkDerivation {
  name = "ideapad-laptop-tb-${kernel.version}";

  passthru.moduleName = "ideapad-laptop-tb";

  hardeningDisable = [ "pic" ];

  src = fetchFromGitHub {
    owner = "ferstar";
    repo = "ideapad-laptop-tb";
    rev = "0c5e1d79a9a43fab61734edfb22c0696ab0b8e95";
    hash = "sha256-pFtP5KmYBrg+0HKTRQYGpzYtoYU63G7yybi+CgS1L7g=";
  };

  nativeBuildInputs = kernel.moduleBuildDependencies;

  buildFlags = [
    "KERNEL_DIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}"
  ];

  installPhase = ''
    install -D ideapad-laptop-tb.ko $out/lib/modules/${kernel.modDirVersion}/misc/ideapad-laptop-tb.ko
  '';
}
