{ config, lib, pkgs, ... }:

let
  nix-tools = with pkgs; [
    nixpkgs-fmt
    nixpkgs-lint
    nixpkgs-review
    nix-index
    nix-du
    manix
  ];

  build-tools = with pkgs; [
    cmake
    gcc
    gdb
    # xmake
    clang
    clang-tools
    cargo
    sassc
    opencc
    rustc
    rustup
    rnix-lsp
    lua
    python3
    git
    nodejs
    nodePackages.pnpm
  ];

  unix-tools = with pkgs; [
    bat
    neovim
    neofetch
    man
    htop
    aria
    scrcpy
    bind
    ripgrep
  ];

  office = with pkgs; [
    # libreoffice-fresh-unwrapped.override{
    #     langs = [ "zh-CN" "en-US" "fr" ];
    # }
    gnumeric
    calibre
    # hunspellq
  ];

  others = with pkgs; [
    rnote # handwritten notes
    #fractal-next # matrix
    # gtkcord4 # discord (WIP)
    tdesktop
    transmission-gtk
    gaphor
    gimp
    # nixos-conf-editor
    # nix-software-center
    vscode-fhs
    minder
    asciinema
    megasync
    nautilus-open-any-terminal
  ];

  my-fonts = pkgs.callPackage (import ./my-fonts) { };
  plangothic = pkgs.callPackage (import ./plangothic) { };

in

{
  environment.systemPackages =
    build-tools
    ++ unix-tools
    ++ nix-tools
    ++ ([ my-fonts plangothic ]);

  users.users.zzzsy.packages =
    office
    ++ others;
}
