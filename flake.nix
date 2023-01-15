{
  description = "zzzsy's NixOS Flake 2.0";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = github:nix-community/NUR;
    nixos-cn = {
      url = "github:nixos-cn/flakes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self, nixpkgs, nur, nixos-cn, home-manager, ...
  } @ inputs: let
    system = "x86_64-linux";
    username = "zzzsy";
  in {
    nixosConfigurations.${username} = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./nixos/configuration.nix
	home-manager.nixosModules.homemanager
	{
          home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.users.zzzsy = import ./home.nix;
	}
	{
          nixos.overlays = [ nur.overlay ];
	}
      ];
      specialArgs = { inherit inputs; };
    };
  };
}
