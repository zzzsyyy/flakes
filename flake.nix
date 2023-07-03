{
  description = "zzzsy's NixOS Flake 2.0";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    impermanence.url = "github:nix-community/impermanence";
    flake-parts.url = "github:hercules-ci/flake-parts";
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.pre-commit-hooks.flakeModule
      ] ++ import ./parts;
      flake = {
        # Put your original flake attributes here.
      };
      systems = [
        "x86_64-linux"
      ];
    };
  # outputs =
  #   { self, nixpkgs, ... } @ inputs:
  #   let
  #     system = "x86_64-linux";
  #     pkgs = inputs.nixpkgs.legacyPackages.${system};
  #     names = with builtins; attrNames (readDir ./pkgs);
  #     genPkg = name: {
  #       inherit name;
  #       value = pkgs.callPackage (./pkgs + "/${name}") { };
  #     };
  #   in
  #   {
  #     nixosConfigurations = import ./hosts {
  #       inherit system self nixpkgs;
  #     };
  #     packages.${system} = builtins.listToAttrs (map genPkg names);
  #     devShells.${system} = {
  #       secret = with pkgs; mkShell {
  #         nativeBuildInputs = [
  #           sops
  #           age
  #           ssh-to-age
  #           ssh-to-pgp
  #         ];
  #         shellHook = ''
  #           export PS1="\e[0;31m(Secret)\w\$ \e[m" 
  #         '';
  #       };
  #     };
  #   };
}
