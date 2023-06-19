{ pkgs, ... }:

let
  nix-tools = with pkgs; [
    nixpkgs-fmt
    nixpkgs-lint
    nixpkgs-review
    nix-index
    nix-du
    nix-tree
  ];

  build-tools = with pkgs; [
    cmake
    # gcc
    # gdb
    # xmake
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
  ];

  unix-tools = with pkgs; [
    bat
    neofetch
    bottom
    aria
    scrcpy
    bind
    ripgrep
    sops
  ];

  office = with pkgs; [
    libreoffice-fresh-unwrapped
    #wpsoffice
    gnumeric
    #calibre
    logseq
    octave
    texlive.combined.scheme-full
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
    default-light
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
