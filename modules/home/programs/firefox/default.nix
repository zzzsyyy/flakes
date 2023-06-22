{ pkgs, lib, ... }:

let

  userChrome = "${pkgs.firefox-gnome-theme}/share/firefox-gnome-theme/userChrome.css";
  userjs = "${pkgs.firefox-gnome-theme}/share/firefox-gnome-theme/configuration/user.js";
  userContent = "${pkgs.firefox-gnome-theme}/share/firefox-gnome-theme/userContent.css";
  myChrome = builtins.readFile ./myChrome.css;
  myContent = builtins.readFile ./myContent.css;

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
    profiles.default = {
      settings = {
        "browser.aboutwelcome.enabled" = false;
        "browser.discovery.enabled" = false;
        "browser.bookmarks.addedImportButton" = false;
        "browser.bookmarks.showMobileBookmarks" = true;
        "fission.autostart" = true;
        "media.peerconnection.enabled" = false;
        "network.IDN_show_punycode" = true;

        "gnomeTheme.bookmarksToolbarUnderTabs" = true;
        "gnomeTheme.normalWidthTabs" = true;
        "gnomeTheme.newTabFullIcon" = true;
        "gnomeTheme.searchBar" = true;
        "gnomeTheme.extensions.tabCenterReborn" = true;
      };
      search = {
        force = true;
        default = "Google UK";
        engines = {
          "Google".metaData.hidden = true;
          "Baidu".metaData.hidden = true;
          "Bing".metaData.hidden = true;
          "Amazon".metaData.hidden = true;
          "Wikipedia (en)".metaData.alias = "@w";
          "Google UK" = {
            urls = [{
              template = "https://www.google.co.uk/search";
              params = [
                { name = "q"; value = "{searchTerms}"; }
              ];
            }];
            definedAliases = [ "@g" ];
          };
          "GitHub" = {
            urls = [{
              template = "https://github.com/search";
              params = [
                { name = "q"; value = "{searchTerms}"; }
              ];
            }];
            definedAliases = [ "@gh" ];
          };
          "Nix" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "channel"; value = "unstable"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
          "Nixpkgs Issues" = {
            urls = [{
              template = "https://github.com/NixOS/nixpkgs/issues";
              params = [
                { name = "q"; value = "{searchTerms}"; }
              ];
            }];
            definedAliases = [ "@ni" ];
          };
        };
      };
      extraConfig = lib.strings.concatStrings [
        (builtins.readFile "${userjs}")
        ''
        ''
      ];
      userChrome = ''
        @import "${userChrome}";
        ${myChrome}
      '';
      userContent = ''
        @import "${userContent}";
        ${myContent}
      '';
    };
  };
}
