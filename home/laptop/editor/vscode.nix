{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = (pkgs.vscode.override {
      commandLineArgs = "--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --disable-features=WaylandFractionalScaleV1 --enable-wayland-ime";
    }).fhsWithPackages (
      ps: with ps; [
        rustup
        zlib
      ]
    );
    # userSettings = builtins.fromJSON (builtins.readFile ./settings.jsonc);
  };
}
