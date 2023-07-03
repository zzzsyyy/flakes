{ config
, lib
, pkgs
, ...
}:
let
  inherit (lib.options) mkEnableOption mkPackageOption;
  inherit (lib.modules) mkIf;

  cfg = config.workarounds.flatpak-fix;

  mkRoSymBind = path: {
    device = path;
    fsType = "fuse.bindfs";
    options = [ "ro" "resolve-symlinks" "x-gvfs-hide" ];
  };
  aggregatedFonts = pkgs.buildEnv {
    name = "system-fonts";
    paths = config.fonts.fonts;
    pathsToLink = [ "/share/fonts" ];
  };
in
{
  options.workarounds.flatpak-fix = {
    enable =
      mkEnableOption "flatpak icons and fonts workaround"
      // {
        default = config.services.flatpak.enable;
        defaultText = "config.services.flatpak.enable";
      };

    bindfsPackage = mkPackageOption pkgs "bindfs" { };
  };

  config = mkIf cfg.enable {
    system.fsPackages = [ cfg.bindfsPackage ];
    fileSystems = {
      "/usr/share/icons" = mkRoSymBind (config.system.path + "/share/icons");
      "/usr/share/fonts" = mkRoSymBind (aggregatedFonts + "/share/fonts");
    };
  };
}
