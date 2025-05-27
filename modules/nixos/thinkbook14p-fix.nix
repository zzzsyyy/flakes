{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.mods.thinkbook14p-fix;
  ideapad-laptop-tb = config.boot.kernelPackages.callPackage ./ideapad-laptop-tb.nix { };
  v4l2loopback = config.boot.kernelPackages.callPackage ./v4l2loopback.nix { };
in
{
  options.mods.thinkbook14p-fix = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    #boot.extraModulePackages = [ ideapad-laptop-tb ];
    #@ TODO
    boot.extraModulePackages = [ v4l2loopback ];
    boot.extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 video_nr=9 card_label="obs"
    '';
    boot.blacklistedKernelModules = [ "ideapad-laptop" ];
  };
}
