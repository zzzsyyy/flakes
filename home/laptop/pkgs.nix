{ pkgs, ... }:

let
  nix-tools = with pkgs; [
    nixfmt-rfc-style
    nix-index
    nix-tree
    nix-output-monitor
    nh
    nil
    nixd
    package-version-server
  ];

  build-tools = with pkgs; [
    cmake
    meson
    gnumake

    clang
    clang-tools
    llvm
    lldb

    rustup
    lua
    python3
    go
    #julia
    nodejs
    pnpm

    git
    just

    #coq
    ghc
    #haskellPackages.cabal-install
    #jdk21
  ];

  unix-tools = with pkgs; [
    bat
    hyfetch
    yazi

    uutils-coreutils-noprefix

    # wasm
    #wasmtime
    #twiggy
    #binaryen
    #wabt

    scrcpy
    bind
    ripgrep
    ffmpeg_7-full
    file
    asciinema
    iw
    b3sum
    tokei
    hyperfine
    rsgain
    # my.odin
    q
    ouch
    pdftk
    duf
    nvfetcher-test
    #steamguard-cli
    rclone

    graphviz
    #zsh
    jq

    my.login
  ];

  office = with pkgs; [
    libreoffice-fresh
    #calibre
    #octave
    typst
    foliate
    typora
    #texlive.combined.scheme-full
    asciidoc-full
    # ghex
    # ida-free
    megasync
    #handbrake
    #scilab-bin
    #feishu
    #mathematica
    #virtualbox
    zed-editor
  ];

  others = with pkgs; [
    # fractal-next # matrix
    # tdesktop
    # microsoft-edge-dev
    tor-browser-bundle-bin
    google-chrome
    zen-browser
    localsend
    # handbrake
    netease-cloud-music-gtk
    waylyrics
    # jellyfin-media-player
    # wireshark
    # gaphor
    # gimp
    # minder
    #tsukimi
    materialgram
    # nur.repos.xddxdd.wechat-uos-sandboxed

    #ghostty

    deluge-gtk

    # vmware-workstation
    adw-gtk3
    ventoy-full-gtk
  ];
in

{
  home.packages = office ++ others ++ build-tools ++ unix-tools ++ nix-tools;
}
