{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    # FIXME
    # use 1.78 until work on wayland
    # https://github.com/microsoft/vscode/issues/192590
    package = pkgs.stable.vscode.fhsWithPackages (
      ps: with ps; [
        rustup
        zlib
      ]
    );
    # userSettings = builtins.fromJSON (builtins.readFile ./settings.jsonc);
  };
}
