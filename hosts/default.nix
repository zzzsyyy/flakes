{ self
, nixpkgs
, system
, ...
}:

let
  inputs = self.inputs;
  nixpkgs-stable = inputs.nixpkgs-stable;
  nixpkgs-small = inputs.nixpkgs-small;

  user = "zzzsy";

in

{
  laptop = nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs; };
    modules = [
      ./laptop
    ] ++ [
      inputs.home-manager.nixosModules.home-manager
      inputs.sops-nix.nixosModules.sops
      inputs.impermanence.nixosModules.impermanence
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${user} = import ../modules/home;
        };
        nixpkgs = {
          overlays =
            (import ../overlays) ++
            [ (import ../pkgs).overlay ]
              ++ [
              (final: prev: {
                stable = import nixpkgs-stable {
                  inherit system;
                  config.allowUnfree = true;
                };
              })
            ]
            ++ [
              (final: prev: {
                small = import nixpkgs-small {
                  inherit system;
                  config.allowUnfree = true;
                };
              })
            ];
        };
      }
    ];
  };
}
