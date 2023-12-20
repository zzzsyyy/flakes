# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  firefox-gnome-theme = {
    pname = "firefox-gnome-theme";
    version = "bad853333d9021e7012adb9b8fbfe7a7003f26bc";
    src = fetchFromGitHub {
      owner = "rafaelmardojai";
      repo = "firefox-gnome-theme";
      rev = "bad853333d9021e7012adb9b8fbfe7a7003f26bc";
      fetchSubmodules = false;
      sha256 = "sha256-M+Cw6vh7xCDmIhyVuEPNmaNVUwpmdFQq8zlsXZTKees=";
    };
    date = "2023-12-19";
  };
  iosevka-zt = {
    pname = "iosevka-zt";
    version = "27.3.5";
    src = fetchurl {
      url = "https://github.com/zzzsyyy/Iosevka/releases/download/v27.3.5/Iosevka-27.3.5.tar.xz";
      sha256 = "sha256-7Uocq6zHX5It2Ivernu1GggCP4ZDZTLRabvFuszMiPQ=";
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
    version = "v1.315";
    src = fetchurl {
      url = "https://github.com/lxgw/LxgwWenKai-Screen/releases/download/v1.315/LXGWWenKaiScreen.ttf";
      sha256 = "sha256-4K797LHyUPzC9hFBicryPxru0ndYsw0YqA1wMGXmSW0=";
    };
  };
  plangothic = {
    pname = "plangothic";
    version = "V1.8.5752";
    src = fetchFromGitHub {
      owner = "Fitzgerald-Porthmouth-Koenigsegg";
      repo = "Plangothic";
      rev = "V1.8.5752";
      fetchSubmodules = false;
      sha256 = "sha256-6Aq8q3jG9Pvn9UZnXdFheReYDtEgIRy7m62nQT2yjuM=";
    };
  };
  rime-ice = {
    pname = "rime-ice";
    version = "c9555ed3c09b3224eb7162047b92ffe744c902b8";
    src = fetchFromGitHub {
      owner = "iDvel";
      repo = "rime-ice";
      rev = "c9555ed3c09b3224eb7162047b92ffe744c902b8";
      fetchSubmodules = false;
      sha256 = "sha256-y2md5i9TJX1BmtQJCB5/HAyLKiViRjJ9mS2onrhEXI8=";
    };
    date = "2023-12-13";
  };
}
