{
  description = "zzzsy's NixOS Flake 2.0";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self, nixpkgs, home-manager, ...
  } @ inputs: let
    system = "x86_64-linux";
    username = "zzzsy";
  in {
    nixosConfigurations.${username} = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./nixos/configuration.nix
        ./modules/gnome.nix
	      home-manager.nixosModules.home-manager
	      {
          home-manager.useGlobalPkgs = true;
	        home-manager.useUserPackages = true;
	        home-manager.users.zzzsy = import ./home.nix;
	      }
      ];
    };
  };
}
