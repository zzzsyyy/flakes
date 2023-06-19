{
  description = "zzzsy's NixOS Flake 2.0";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs =
    { self, nixpkgs, ... } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    in
    {
      nixosConfigurations = import ./hosts {
        inherit system self nixpkgs;
      };
      devShells.${system} = {
        secret = with pkgs; mkShell {
          nativeBuildInputs = [
            sops
            age
            ssh-to-age
            ssh-to-pgp
          ];
          shellHook = ''
            export PS1="\e[0;31m(Secret)\w\$ \e[m" 
          '';
        };
      };
    };
}
