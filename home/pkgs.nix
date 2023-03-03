{ pkgs, ... }:

let
  nix-tools = with pkgs; [
    nixpkgs-fmt
    nixpkgs-lint
    nixpkgs-review
    nix-index
    nix-du
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
  ];

  unix-tools = with pkgs; [
    bat
    neofetch
    viu
    man
    htop
    aria
    scrcpy
    bind
    ripgrep
    sops
  ];

  office = with pkgs; [
    libreoffice-fresh-unwrapped
    gnumeric
    calibre
    #logseq
    octave
    # hunspellq
  ];

  others = with pkgs; [
    # rnote # handwritten notes
    # fractal-next # matrix
    # gtkcord4 # discord (WIP)
    tdesktop
    transmission-gtk
    gaphor
    gimp
    # nixos-conf-editor
    # nix-software-center
    minder
    asciinema
    megasync
    # nautilus-open-any-terminal
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
