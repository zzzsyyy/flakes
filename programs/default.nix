{
  config,
  lib,
  pkgs,
  ...
}: {
    imports = [
        ./git.nix
        # ./neovim.nix
        # ./vsc.nix
    ];
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
        profiles.default.settings = {
            "browser.bookmarks.showMobileBookmarks" = true;
            "fission.autostart" = true;
            "media.peerconnection.enabled" = false;
            "network.IDN_show_punycode" = true;
        };
    };

    programs.starship = {
      enable = true;
      settings = builtins.fromTOML (builtins.readFile ./starship.toml);
    };

    programs.wezterm = {
        enable = true;
        extraConfig = builtins.readFile (./wezterm.lua);
    };

    programs.lsd = {
        enable = true;
        enableAliases = true;
    };

    programs.zsh = {
        enable = true;
        enableAutosuggestions = true;
        enableCompletion = true;
        enableSyntaxHighlighting = true;
        dotDir = ".config/zsh";
        history = {
            path = "${config.xdg.cacheHome}/.histfile";
            size = 100000;
            save = 100000;
            expireDuplicatesFirst = true;
            ignorePatterns = [ ":q" "clc" ];
        };
        historySubstringSearch.enable = true;
        shellAliases = {
            pb="curl -F 'c=@-' 'https://fars.ee/'";
            gst="git status";
            n="neofetch";
            setproxy="export ALL_PROXY=socks://127.0.0.1:7890";
            unsetproxy="unset ALL_PROXY";
            clc="clear";
            ":q"="exit";
            snvim="EDITOR=nvim sudoedit";
        };
        dirHashes = {
            docs  = "$HOME/Documents";
            code  = "$HOME/Documents/Code";
            dl    = "$HOME/Downloads";
        };
        initExtra = ''
            zstyle ':completion:*' menu select
        '';
    };

}