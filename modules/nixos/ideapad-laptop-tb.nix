{
  stdenv,
  fetchFromGitHub,
  kernel,
}:

stdenv.mkDerivation {
  name = "ideapad-laptop-tb2024-${kernel.version}";

  passthru.moduleName = "ideapad-laptop-tb2024";

  hardeningDisable = [ "pic" ];

  src = fetchFromGitHub {
    owner = "zzzsyyy";
    repo = "ideapad-laptop-tb2024";
    rev = "4bccd3e460668481d7e2954fcd41c396bb3e5794";
    hash = "sha256-IKYtBdOCvPC1wPY7AV/3ml2YIsgxVRpR0zH2E9V2phU=";
  };

  nativeBuildInputs = kernel.moduleBuildDependencies;

  buildFlags = [
    "KERNEL_DIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}"
  ];

  installPhase = ''
    install -D ideapad-laptop-tb2024.ko $out/lib/modules/${kernel.modDirVersion}/misc/ideapad-laptop-tb2024.ko
  '';
}
