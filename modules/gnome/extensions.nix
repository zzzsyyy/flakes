{ pkgs, ... }:

{
  config.environment.systemPackages = with pkgs.gnomeExtensions; [
    user-themes
    gsconnect
    appindicator
    removable-drive-menu
    clipboard-indicator
    caffeine
    dash-to-panel
    unite
    night-theme-switcher
    rounded-window-corners
    rounded-corners
    customize-ibus
    paperwm
  ];
}
