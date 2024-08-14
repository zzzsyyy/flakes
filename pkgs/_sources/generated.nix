# This file was generated by nvfetcher, please do not modify it manually.
{
  fetchgit,
  fetchurl,
  fetchFromGitHub,
  dockerTools,
}:
{
  dae = {
    pname = "dae";
    version = "00f1df66966c51f8a2a96475b3cd287e1bd3113f";
    src = fetchFromGitHub {
      owner = "daeuniverse";
      repo = "dae";
      rev = "00f1df66966c51f8a2a96475b3cd287e1bd3113f";
      fetchSubmodules = true;
      sha256 = "sha256-ofn9pmCaXWKzXHTpR9iLTi+0u+EUt8mPsVd/JOmFUe4=";
    };
    date = "2024-08-08";
  };
  firefox-gnome-theme = {
    pname = "firefox-gnome-theme";
    version = "fb5b578a4f49ae8705e5fea0419242ed1b8dba70";
    src = fetchFromGitHub {
      owner = "rafaelmardojai";
      repo = "firefox-gnome-theme";
      rev = "fb5b578a4f49ae8705e5fea0419242ed1b8dba70";
      fetchSubmodules = false;
      sha256 = "sha256-MOE9NeU2i6Ws1GhGmppMnjOHkNLl2MQMJmGhaMzdoJM=";
    };
    date = "2024-08-08";
  };
  iosevka-zt = {
    pname = "iosevka-zt";
    version = "30.0.1";
    src = fetchurl {
      url = "https://github.com/zzzsyyy/Iosevka/releases/download/v30.0.1/Iosevka-30.0.1.txz";
      sha256 = "sha256-5/W+FXherikLcDlzO3C78RS1+BOV+8eOZWTZypuhVJ4=";
    };
  };
  librime-lua = {
    pname = "librime-lua";
    version = "7be6974b6d81c116bba39f6707dc640f6636fa4e";
    src = fetchFromGitHub {
      owner = "hchunhui";
      repo = "librime-lua";
      rev = "7be6974b6d81c116bba39f6707dc640f6636fa4e";
      fetchSubmodules = false;
      sha256 = "sha256-jsrnAFE99d0U0LdddTL7G1p416qJfSNR935TZFH3Swk=";
    };
    date = "2024-05-19";
  };
  lxgw-wenkai-screen = {
    pname = "lxgw-wenkai-screen";
    version = "v1.330";
    src = fetchurl {
      url = "https://github.com/lxgw/LxgwWenKai-Screen/releases/download/v1.330/LXGWWenKaiScreen.ttf";
      sha256 = "sha256-3C6gZmL5Bn6+26TfI2UdCCnGI8Vw4UTFJRc8n6qlP5o=";
    };
  };
  plangothic = {
    pname = "plangothic";
    version = "V1.8.5764";
    src = fetchFromGitHub {
      owner = "Fitzgerald-Porthmouth-Koenigsegg";
      repo = "Plangothic-Project";
      rev = "V1.8.5764";
      fetchSubmodules = false;
      sha256 = "sha256-+vKUWaqBwM4WUon9pEC5Fg/HngKQuhTkWXDF8g9ov1w=";
    };
  };
  rime-ice = {
    pname = "rime-ice";
    version = "f37863cbc5073d4adfe305fe5a9f3af3ae67814d";
    src = fetchFromGitHub {
      owner = "iDvel";
      repo = "rime-ice";
      rev = "f37863cbc5073d4adfe305fe5a9f3af3ae67814d";
      fetchSubmodules = false;
      sha256 = "sha256-hTqvsiAf0rYMzMqfsfPOJU7Rtbx0gQlpsjiKxBY2Hc8=";
    };
    date = "2024-08-13";
  };
}
