{ pkgs
, ...
}:

{
  imports = [ ];
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
    programs.dconf.enable = true;
    # fix nautilus extensions deu to `core-utilities.enable = false`
    workarounds.gnome-fix.enable = true;
    environment.systemPackages = (with pkgs; [
      remmina
      ffmpegthumbnailer
      amberol # music
      loupe # image
      gnome-text-editor
      epiphany
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
