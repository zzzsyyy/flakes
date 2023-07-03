{ pkgs, lib, ... }:

let
  userjs = "${pkgs.my.firefox-gnome-theme}/share/firefox-gnome-theme/configuration/user.js";
in

{
  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-bin-unwrapped {
      extraPolicies = {
        DisablePocket = true;
        DisableTelemetry = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
      };
    };
    #@TODO muilti profile
    profiles.default = {
      settings = import ./config/settings.nix;
      search = import ./config/search.nix;
      userChrome = import ./config/userChrome.nix;
      userContent = import ./config/userContent.nix;
      extraConfig = lib.strings.concatStrings [
        (builtins.readFile "${userjs}")
        ''
        ''
      ];
    };
  };
}
