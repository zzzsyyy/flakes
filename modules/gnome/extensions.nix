{ pkgs, ... }:

{
  config.environment.systemPackages = with pkgs.gnomeExtensions; [
    user-themes
    gsconnect
    appindicator
    removable-drive-menu
    clipboard-indicator
    date-menu-formatter
    openweather
    #bluetooth-quick-connect
    caffeine
    dash-to-panel
    unite
    #dash-to-dock
    night-theme-switcher
    rounded-window-corners
    rounded-corners
    customize-ibus
    #space-bar
    #workspace-switcher-manager
    fuzzy-app-search
  ];
}
