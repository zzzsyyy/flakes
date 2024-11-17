# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  firefox-gnome-theme = {
    pname = "firefox-gnome-theme";
    version = "823756d8ddd21cfd3a24a87dad402e490e0eb5ee";
    src = fetchFromGitHub {
      owner = "rafaelmardojai";
      repo = "firefox-gnome-theme";
      rev = "823756d8ddd21cfd3a24a87dad402e490e0eb5ee";
      fetchSubmodules = false;
      sha256 = "sha256-lf9MQs8+NUvQd8b5t+7c4kLqUQixGO9WwWcLa1XYuiQ=";
    };
    date = "2024-11-03";
  };
  iosevka-zt = {
    pname = "iosevka-zt";
    version = "31.2.0";
    src = fetchurl {
      url = "https://github.com/zzzsyyy/Iosevka/releases/download/v31.2.0/Iosevka-31.2.0.txz";
      sha256 = "sha256-9rL+gEuWqIYlTJ8GA6ylVEgDYj02HfQ08Jic8WWmhYA=";
    };
  };
  librime-lua = {
    pname = "librime-lua";
    version = "b210d0cfbd2a3cc6edd4709dd0a92c479bfca10b";
    src = fetchFromGitHub {
      owner = "hchunhui";
      repo = "librime-lua";
      rev = "b210d0cfbd2a3cc6edd4709dd0a92c479bfca10b";
      fetchSubmodules = false;
      sha256 = "sha256-ETjLN40G4I0FEsQgNY8JM4AInqyb3yJwEJTGqdIHGWg=";
    };
    date = "2024-11-02";
  };
  lxgw-wenkai-screen = {
    pname = "lxgw-wenkai-screen";
    version = "v1.501";
    src = fetchurl {
      url = "https://github.com/lxgw/LxgwWenKai-Screen/releases/download/v1.501/LXGWWenKaiScreen.ttf";
      sha256 = "sha256-em3uh53neN8v1ueiw1rWVtC0bteD7IG3X1g9tkjBRJA=";
    };
  };
  plangothic = {
    pname = "plangothic";
    version = "V1.9.5766";
    src = fetchFromGitHub {
      owner = "Fitzgerald-Porthmouth-Koenigsegg";
      repo = "Plangothic-Project";
      rev = "V1.9.5766";
      fetchSubmodules = false;
      sha256 = "sha256-wdDhKINEHNrayliUwOXNg0jIg4/W3TH9VjETblJGqvE=";
    };
  };
  rime-ice = {
    pname = "rime-ice";
    version = "728dcc5051a62b5b481cd52126eaecf3408d8f72";
    src = fetchFromGitHub {
      owner = "iDvel";
      repo = "rime-ice";
      rev = "728dcc5051a62b5b481cd52126eaecf3408d8f72";
      fetchSubmodules = false;
      sha256 = "sha256-riM18c1fcEP5N/0jAcrpqrqF9ldNA8JMnd3gSV20Odk=";
    };
    date = "2024-11-17";
  };
}
