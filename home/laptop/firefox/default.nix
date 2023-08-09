{ pkgs
, lib
, ...
}:

let
  userJs = "${pkgs.my.firefox-gnome-theme}/share/firefox-gnome-theme/configuration/user.js";
  userChrome = "${pkgs.my.firefox-gnome-theme}/share/firefox-gnome-theme/userChrome.css";
  userContent = "${pkgs.my.firefox-gnome-theme}/share/firefox-gnome-theme/userContent.css";
in

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-nightly-bin.override {
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
      userChrome = lib.strings.concatStrings [
        ''
          @import "${userChrome}";
        ''
        (builtins.readFile ./config/custom/sidebery_dyn.css)
      ];
      userContent = lib.strings.concatStrings [
        ''
          @import "${userContent}";
        ''
        (builtins.readFile ./config/custom/userContent.css)
      ];
      extraConfig = lib.strings.concatStrings [
        (builtins.readFile "${userJs}")
        ''
        ''
      ];
    };
  };
}
