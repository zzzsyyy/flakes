{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.workarounds.gnome-fix;
in
{
  options.workarounds.gnome-fix = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
    gst-plugins = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ gnome.nautilus-python ] ++ [
      nautilus-open-any-terminal
    ];
    services.xserver.desktopManager.gnome.extraGSettingsOverridePackages = with pkgs; [
      nautilus-open-any-terminal
    ];
    environment.pathsToLink = [
      "/share/nautilus-python/extensions"
    ];
    environment.sessionVariables.NAUTILUS_4_EXTENSION_DIR = "${config.system.path}/lib/nautilus/extensions-4";
    environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 = mkIf cfg.gst-plugins (makeSearchPathOutput "lib" "lib/gstreamer-1.0" (with pkgs.gst_all_1; [
      gst-plugins-good
      gst-plugins-bad
      gst-plugins-ugly
      gst-libav
    ]));
  };
}
