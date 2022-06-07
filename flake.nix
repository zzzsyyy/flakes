{
  description = "zzzsy's NixOS Flake";

  # 输入配置，即软件源
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
#    flake-utils.url = "github:numtide/flake-utils";
    nur.url = github:nix-community/NUR;
    nixos-cn = {
      url = "github:nixos-cn/flakes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
#    flake-compat = {
#      url = "github:edolstra/flake-compat";
#      flake = false;
#    };
#   nvfetcher = {
#      url = "github:berberman/nvfetcher";
#      inputs.nixpkgs.follows = "nixpkgs";
#      inputs.flake-compat.follows = "flake-compat";
#      inputs.flake-utils.follows = "flake-utils";
#    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
#    sops-nix = {
#      url = "github:Mic92/sops-nix";
#      inputs.nixpkgs.follows = "nixpkgs";
#    };
  };

  # 输出配置，即 NixOS 系统配置
  outputs = {
    self,
    nixpkgs,
    nur,
    nixos-cn,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    username = "zzzsy";
  in {
    nixosConfigurations.${username} = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./nixos/configuration.nix
        home-manager.nixosModules.home-manager
	{
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.users.zzzsy = import ./home.nix;
	}
	{
	  nixpkgs.overlays = [
	    nur.overlay
	  ];
        }
	({ ... }:{
          environment.systemPackages =
              [ nixos-cn.legacyPackages.${system}.wechat-uos ];
	})
      ];
      specialArgs = { inherit inputs;};
    };
  };
}
