{ self
, inputs
, ...
}:
let
  username = "zzzsy";

  inherit (inputs) home-manager nixpkgs impermanence firefox-nightly sops-nix;

  inherit (nixpkgs.lib) attrValues;
  mkHost =
    { hostName
    , system
    , modules
    , overlays ? [ ]
    }:
    {
      ${hostName} = nixpkgs.lib.nixosSystem {
        inherit system;

        modules =
          [
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                sharedModules = attrValues self.hmModules;
              };
              nixpkgs = {
                overlays = (import ../overlays)
                ++ [
                  (final: prev: {
                    firefox-nightly-bin = firefox-nightly.packages.${prev.system}.firefox-nightly-bin;
                    my = self.packages."${system}";
                    stable = import inputs.nixpkgs-stable {
                      inherit system;
                      config.allowUnfree = true;
                    };
                    unstable = import inputs.nixpkgs-unstable {
                      inherit system;
                      config.allowUnfree = true;
                    };
                  })
                ];
              };
              networking.hostName = hostName;
            }

            home-manager.nixosModules.home-manager
            ../hosts/common
            ../hosts/${hostName}
            (import ../home username)
          ]
          ++ (attrValues self.nixosModules)
          ++ modules;
        specialArgs = { inherit inputs; };
      };
    };
in
{
  flake.nixosConfigurations =
    (mkHost {
      system = "x86_64-linux";
      hostName = "laptop";
      modules = [
        impermanence.nixosModules.impermanence
        sops-nix.nixosModules.sops
        # nixos-hardware.nixosModules.common-cpu-amd-pstate
        # nixos-hardware.nixosModules.common-gpu-amd
        # nixos-hardware.nixosModules.common-pc-ssd
      ];
    });
}
