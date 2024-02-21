# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  firefox-gnome-theme = {
    pname = "firefox-gnome-theme";
    version = "7a1a81baa7c31d75764dcea908285e487302d32a";
    src = fetchFromGitHub {
      owner = "rafaelmardojai";
      repo = "firefox-gnome-theme";
      rev = "7a1a81baa7c31d75764dcea908285e487302d32a";
      fetchSubmodules = false;
      sha256 = "sha256-SYp0DRkO73i8XVyOdAlcP2ZItqx9DqraIEJy6mY/2Ng=";
    };
    date = "2024-01-07";
  };
  gnome-shell-extension-quake-mode = {
    pname = "gnome-shell-extension-quake-mode";
    version = "50d4505d109ac474ed7b82397447559ddcebd7f8";
    src = fetchFromGitHub {
      owner = "repsac-by";
      repo = "gnome-shell-extension-quake-mode";
      rev = "50d4505d109ac474ed7b82397447559ddcebd7f8";
      fetchSubmodules = false;
      sha256 = "sha256-er71pDa13orFVerWLKVGb2jR+74AUbRWhZZAgW+xm7g=";
    };
    date = "2023-12-26";
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
    version = "7f3eca2ce659fc2401b8acb52bd2182b433e12b1";
    src = fetchFromGitHub {
      owner = "hchunhui";
      repo = "librime-lua";
      rev = "7f3eca2ce659fc2401b8acb52bd2182b433e12b1";
      fetchSubmodules = false;
      sha256 = "sha256-n+KCu8JmFBGPyfBgeLiFqND3wmQs/4eOZjqTXuaW+hk=";
    };
    date = "2024-02-06";
  };
  lxgw-wenkai-screen = {
    pname = "lxgw-wenkai-screen";
    version = "v1.321";
    src = fetchurl {
      url = "https://github.com/lxgw/LxgwWenKai-Screen/releases/download/v1.321/LXGWWenKaiScreen.ttf";
      sha256 = "sha256-KdefRqGJWl8+ZB6UOTZPwibKgjbaHe78QRcdMFGo1SM=";
    };
  };
  plangothic = {
    pname = "plangothic";
    version = "V1.8.5757";
    src = fetchFromGitHub {
      owner = "Fitzgerald-Porthmouth-Koenigsegg";
      repo = "Plangothic";
      rev = "V1.8.5757";
      fetchSubmodules = false;
      sha256 = "sha256-d2CK+OSkMxmAt8qogCyG/J841JI9qG+3xM8TVoWe96Q=";
    };
  };
  q = {
    pname = "q";
    version = "v0.19.2";
    src = fetchFromGitHub {
      owner = "natesales";
      repo = "q";
      rev = "v0.19.2";
      fetchSubmodules = false;
      sha256 = "sha256-kfuf0iwRYNxd9TfIIHvAqLxXjesQh7jC0evT9DQrrzQ=";
    };
  };
  rime-ice = {
    pname = "rime-ice";
    version = "362288fed5814b3fe10fe9819672767c38d836c9";
    src = fetchFromGitHub {
      owner = "iDvel";
      repo = "rime-ice";
      rev = "362288fed5814b3fe10fe9819672767c38d836c9";
      fetchSubmodules = false;
      sha256 = "sha256-8ZC9qt2xbV9/J6te/ngxJayvcLTDMT44/QsgmYHEc0U=";
    };
    date = "2024-02-21";
  };
}
