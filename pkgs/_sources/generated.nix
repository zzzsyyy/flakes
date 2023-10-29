# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  firefox-gnome-theme = {
    pname = "firefox-gnome-theme";
    version = "v119";
    src = fetchFromGitHub {
      owner = "rafaelmardojai";
      repo = "firefox-gnome-theme";
      rev = "v119";
      fetchSubmodules = false;
      sha256 = "sha256-OU6LyGeePS31pG7o10su7twDzDL5Z3a1sHtV68SzEwI=";
    };
  };
  iosevka-zt = {
    pname = "iosevka-zt";
    version = "27.1.0";
    src = fetchurl {
      url = "https://github.com/zzzsyyy/Iosevka/releases/download/v27.1.0/Iosevka-27.1.0.tar.xz";
      sha256 = "sha256-jhF5qFlWHWSJLxSGFvK7/FJOccELPQ/x4vypR7JfdZE=";
    };
  };
  librime-lua = {
    pname = "librime-lua";
    version = "7c297e4d2e08fcdd3e9b2dcae2a42317b9a217ff";
    src = fetchFromGitHub {
      owner = "hchunhui";
      repo = "librime-lua";
      rev = "7c297e4d2e08fcdd3e9b2dcae2a42317b9a217ff";
      fetchSubmodules = false;
      sha256 = "sha256-GVfr2fzaQYyfNnjN20YcNfBVB144gZKVEunbX10Mgeg=";
    };
    date = "2023-10-29";
  };
  lxgw-wenkai-screen = {
    pname = "lxgw-wenkai-screen";
    version = "v1.311";
    src = fetchurl {
      url = "https://github.com/lxgw/LxgwWenKai-Screen/releases/download/v1.311/LXGWWenKaiScreen.ttf";
      sha256 = "sha256-BLVICsBkAD+Lrz1WwwNP3G3qALHjx0NVMkpArcpY9uE=";
    };
  };
  plangothic = {
    pname = "plangothic";
    version = "V1.8.5746";
    src = fetchFromGitHub {
      owner = "Fitzgerald-Porthmouth-Koenigsegg";
      repo = "Plangothic";
      rev = "V1.8.5746";
      fetchSubmodules = false;
      sha256 = "sha256-PW0P6Ndekmsw6Y1ChCKHSVRxLPtqwYmi4CnrptpfUfE=";
    };
  };
  rime-ice = {
    pname = "rime-ice";
    version = "0e843f998f659e6329e38192ceaa60165412abd8";
    src = fetchFromGitHub {
      owner = "iDvel";
      repo = "rime-ice";
      rev = "0e843f998f659e6329e38192ceaa60165412abd8";
      fetchSubmodules = false;
      sha256 = "sha256-ZdirhWKq0ZHECyiruooH39od+yoHq/5LZoNSHuu8WPk=";
    };
    date = "2023-10-22";
  };
}
