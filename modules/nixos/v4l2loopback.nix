{
  lib,
  stdenv,
  fetchFromGitHub,
  kernel,
  kmod,
  kernelModuleMakeFlags,
}:

let
  version = "0.15.0-unstable-2025-04-29";

in
stdenv.mkDerivation {
  pname = "v4l2loopback";
  version = "${version}-${kernel.version}";

  src = fetchFromGitHub {
    owner = "umlaeute";
    repo = "v4l2loopback";
    rev = "8d806ad688961d8840081a609c39d1a82d296b24";
    hash = "sha256-STJTQzk8OFQH0ceQk/5qKEGXE2eLyIEeyxqFHBqPQW4=";
  };

  hardeningDisable = [
    "format"
    "pic"
  ];

  preBuild = ''
    substituteInPlace Makefile --replace "modules_install" "INSTALL_MOD_PATH=$out modules_install"
    sed -i '/depmod/d' Makefile
  '';

  nativeBuildInputs = [ kmod ] ++ kernel.moduleBuildDependencies;

  postInstall = ''
    make install-utils PREFIX=$bin
  '';

  outputs = [
    "out"
    "bin"
  ];

  makeFlags = kernelModuleMakeFlags ++ [
    "KERNELRELEASE=${kernel.modDirVersion}"
    "KERNEL_DIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  ];

  meta = with lib; {
    description = "Kernel module to create V4L2 loopback devices";
    mainProgram = "v4l2loopback-ctl";
    homepage = "https://github.com/umlaeute/v4l2loopback";
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ moni ];
    platforms = platforms.linux;
    outputsToInstall = [ "out" ];
  };
}