{
  description = "zzzsy's NixOS Flake 3.0";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager.url = "github:nix-community/home-manager";

    sops-nix.url = "github:Mic92/sops-nix";
    preservation.url = "github:WilliButz/preservation";
    flake-parts.url = "github:hercules-ci/flake-parts";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    daeuniverse.url = "github:daeuniverse/flake.nix";
    infuse.url = "git+https://codeberg.org/amjoseph/infuse.nix.git";
    infuse.flake = false;

    lanzaboote.url = "github:nix-community/lanzaboote";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";

    nvfetcher.url = "github:berberman/nvfetcher";
    nvfetcher.inputs.nixpkgs.follows = "nixpkgs";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    niri.url = "github:sodiboo/niri-flake";
    niri.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
    #stylix.url = "github:danth/stylix";

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self, flake-parts, ... }:
    let
      lib = inputs.nixpkgs.lib.extend (
        self: super: {
          my = import ./lib {
            inherit inputs;
            lib = self;
          };
        }
      );
    in
    flake-parts.lib.mkFlake
      {
        inherit inputs;
        specialArgs.lib = lib;
      }
      {
        imports = [
          inputs.pre-commit-hooks.flakeModule
        ]
        ++ import ./parts;
        systems = [ "x86_64-linux" ];
      };
}
