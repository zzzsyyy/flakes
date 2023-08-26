{ pkgs
, lib
, ...
}:

{
  imports = [
    ./extensions.nix
  ];
  config = {
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    services.xserver.excludePackages = [ pkgs.xterm ];
    services.xserver.desktopManager.xterm.enable = false;
    services.gnome = {
      core-utilities.enable = false;
      gnome-online-accounts.enable = false;
      gnome-browser-connector.enable = true;
      tracker-miners.enable = false;
      tracker.enable = false;
    };
    environment.gnome.excludePackages = (with pkgs; [
      gnome-tour
      orca
      #]) ++ (with pkgs.gnome; [
    ]);
    environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" (with pkgs.gst_all_1; [
      gst-plugins-good
      gst-plugins-bad
      gst-plugins-ugly
      gst-libav
    ]);
    programs.dconf.enable = true;
    environment.systemPackages = (with pkgs; [
      ffmpegthumbnailer
      amberol # music
      feh # image
      gnome-text-editor
    ]) ++ (with pkgs.gnome; [
      nautilus # file
      file-roller # archive
      evince # pdf
      gnome-tweaks
      gnome-calendar
      dconf-editor
      seahorse
      gnome-disk-utility
      # loupe # https://github.com/NixOS/nixpkgs/pull/202692
      # gnome-sound-recorder
      # gnome-power-manager
    ]);
  };
}
