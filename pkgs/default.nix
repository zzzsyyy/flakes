{ config, lib, pkgs, ...}: 

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
    gcc gdb
    # xmake
    clang
    clang-tools
    cargo
    rustc
    rustup
    rust-analyzer
    rnix-lsp
    lua
    git
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
    fractal-next # matrix
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

my-fonts = pkgs.callPackage (import ./my-fonts) {};

in

{
environment.systemPackages = 
        build-tools
    ++  unix-tools
    ++  nix-tools
    ++  ([ my-fonts ]);

users.users.zzzsy.packages = 
        office
    ++  others;
}