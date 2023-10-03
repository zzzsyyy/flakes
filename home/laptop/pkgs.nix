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
    lua
    python3
    git
    nodejs
    nodePackages.pnpm
    hugo
    go
    # julia
    just
    libjxl
    # nvfetcher
    ghc
    haskellPackages.cabal-install
  ];

  unix-tools = with pkgs; [
    bat
    #linuxKernel.packages.linux_xanmod_stable.cpupower
    #@TODO update BIOS
    #dmidecode
    #neofetch
    hyfetch
    bottom
    scrcpy
    bind
    ripgrep
    ffmpeg_6-full
    file
    megacmd
    asciinema
    iw
    #appimage-run
    tokei
    hyperfine
    my.odin
    my.naive
    innoextract
    ouch
    lf
    pdftk
  ];

  office = with pkgs; [
    libreoffice-fresh
    #calibre
    octave
    typst
    texlive.combined.scheme-full
    asciidoc-full
    # hunspellq
  ];

  others = with pkgs; [
    # rnote # handwritten notes
    # fractal-next # matrix
    # gtkcord4 # discord (WIP)
    tdesktop
    # elec
    #ngspice
    #qucs-s
    tor-browser-bundle-bin
    #handbrake
    go-musicfox
    # blueman
    #wireshark
    #gaphor
    #gimp
    #minder
    adw-gtk3
    my.default-light
    # my.ascii-draw
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
