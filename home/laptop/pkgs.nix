{ pkgs, ... }:

let
  nix-tools = with pkgs; [
    nixpkgs-fmt
    nixpkgs-lint
    nixpkgs-review
    nix-index
    nix-du
    nix-tree
    nix-output-monitor
  ];

  build-tools = with pkgs; [
    cmake
    # gcc
    # gdb
    clang
    clang-tools
    sassc
    opencc
    rustup
    rnix-lsp
    lua
    python3
    git
    nodejs
    nodePackages.pnpm
    hugo
    go
    julia
    just
    libjxl
    flaca
    hysteria
    nvfetcher
  ];

  unix-tools = with pkgs; [
    bat
    neofetch
    bottom
    scrcpy
    bind
    ripgrep
    sops
    ffmpeg_6
    glow
  ];

  office = with pkgs; [
    libreoffice-fresh-unwrapped
    gnumeric
    #calibre
    logseq
    octave
    texlive.combined.scheme-full
    asciidoc-full
    # hunspellq
  ];

  others = with pkgs; [
    # rnote # handwritten notes
    # fractal-next # matrix
    # gtkcord4 # discord (WIP)
    tdesktop
    #gaphor
    #gimp
    #minder
    asciinema
    megasync
    adw-gtk3
    my.default-light
    (ventoy.override {
      defaultGuiType = "gtk3";
      withGtk3 = true;
    })
  ];

in

{
  home.packages =
    office
    ++ others
    ++ build-tools
    ++ unix-tools
    ++ nix-tools;
}
