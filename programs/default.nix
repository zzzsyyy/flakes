{
  config,
  lib,
  pkgs,
  ...
}:
let bg = pkgs.fetchurl {
  url = "https://img.zzzsy.top/1.jpg";
  name = "nixos.jpg";
  hash = "sha256-du+AGCUSUJzbY/OYvhP0HSXM86JJNZfYJs+CxscU5IA=";
};
in
{
  imports = [
    ./git.nix
    ./neovim.nix
    ./vsc.nix
  ];
  programs = {
    firefox = {
      enable = true;
      package = pkgs.wrapFirefox pkgs.firefox-beta-bin-unwrapped {
        forceWayland = true;
        extraPolicies = {
          DisablePocket = true;
          EnableTrackingProtection = {
            Value = true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
          };
        };
      };
      profiles.default.settings = {
        "browser.bookmarks.showMobileBookmarks" = true;
        "fission.autostart" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.rdd-ffmpeg.enabled" = true;
      };
    };
    waybar = {
      enable = true;
      settings = (import ./waybar.nix);
      style = builtins.readFile ./waybar.css;
      systemd.enable = true;
    };
    kitty = {
      enable = true;
      extraConfig = builtins.readFile (./kitty.conf);
    };
    starship = {
      enable = true;
      settings = builtins.fromTOML (builtins.readFile ./starship.toml);
    };
    sioyek = {
      enable = true;
    };
    swaylock.settings = {
      image = "${bg}";
      show-failed-attempts = true;
      indicator-caps-lock = true;
      ignore-empty-password = true;
      show-keyboard-layout = true;
    };
  };
}
