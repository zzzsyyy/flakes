{ pkgs, lib, ... }:

let
  userJs = "${pkgs.my.firefox-gnome-theme}/share/firefox-gnome-theme/configuration/user.js";
  userChrome = "${pkgs.my.firefox-gnome-theme}/share/firefox-gnome-theme/userChrome.css";
  userContent = "${pkgs.my.firefox-gnome-theme}/share/firefox-gnome-theme/userContent.css";
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
      userChrome = ''
        @import "${userChrome}";
        @import usi(./custom/fix_gnome_bookmark.css);
        @import uri(./custom/sidebery_dyn.css);
      '';
      userContent = ''
        @import "${userContent}";
        @import uri(./custom/userContent.css);
      '';
      extraConfig = lib.strings.concatStrings [
        (builtins.readFile "${userJs}")
        ''
        ''
      ];
    };
  };
}
