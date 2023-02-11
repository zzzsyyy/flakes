{
  description = "zzzsy's NixOS Flake 2.0";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix.url = github:Mic92/sops-nix;
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , sops-nix
    , ...
    } @ inputs:
    let
      system = "x86_64-linux";
      username = "zzzsy";
      pkgs = import nixpkgs {
        inherit system;
      };

    in
    {
      nixosModules = {
        gnome = ./home/gnome/default.nix;
        declarativeHome = {
          config.home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${username} = import ./home/home.nix;
          };
          config.nixpkgs = {
            overlays =
              [ (import ./pkgs) ]
              # ++ (import ./overlays)
              # ++ [
              #   inputs.neovim-nightly-overlay.overlay
              # ]
            ;
          };
        };
        networking = ./home/networking/default.nix;
        sops = ./sops/default.nix;
      };
      nixosConfigurations.${username} = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = with self.nixosModules; [
          ./nixos/configuration.nix
          gnome
          home-manager.nixosModules.home-manager
          declarativeHome
          sops-nix.nixosModules.sops
          networking
          sops
        ];
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
