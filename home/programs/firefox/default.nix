{ pkgs, ... }:

let

  userChrome = "${pkgs.firefox-gnome-theme}/share/firefox-gnome-theme/userChrome.css";
  userjs = "${pkgs.firefox-gnome-theme}/share/firefox-gnome-theme/configuration/user.js";
  userContent = "${pkgs.firefox-gnome-theme}/share/firefox-gnome-theme/userContent.css";

in

{
  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-bin-unwrapped {
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
    profiles.default = {
      settings = {
        "browser.bookmarks.showMobileBookmarks" = true;
        "fission.autostart" = true;
        "media.peerconnection.enabled" = false;
        "network.IDN_show_punycode" = true;
      };
      extraConfig = builtins.readFile "${userjs}";
      userChrome = ''
        @import "${userChrome}";
      '';
      userContent = ''
        @import "${userContent}";
      '';
    };
  };
}
