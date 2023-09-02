{ pkgs
, ...
}:

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
    rustup
    # rnix-lsp
    lua
    python3
    git
    nodejs
    nodePackages.pnpm
    hugo
    go
    # julia
    just
    # my.libjxl-with-plugin
    libjxl
    # nvfetcher
  ];

  unix-tools = with pkgs; [
    bat
    neofetch
    bottom
    scrcpy
    bind
    ripgrep
    sops
    ffmpeg_6-full
    dae
    file
    asciinema
    iw
    appimage-run
    tokei
    my.odin
  ];

  office = with pkgs; [
    libreoffice-fresh
    #calibre
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
    tor-browser-bundle-bin
    handbrake
    go-musicfox
    # blueman
    #wireshark
    #gaphor
    #gimp
    #minder
    adw-gtk3
    my.default-light
    my.ascii-draw
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
