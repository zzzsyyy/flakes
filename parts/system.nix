{ self
, inputs
, ...
}:
let
  username = "zzzsy";

  inherit (inputs) home-manager nixpkgs impermanence sops-nix chaotic nvfetcher daeuniverse lanzaboote;

  inherit (nixpkgs.lib) attrValues;
  mkHost =
    { hostName
    , system
    , modules
    , overlays ? [ nvfetcher.overlays.default ]
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
                # overlays = (import ../overlays)
                overlays = [
                  (final: prev: {
                    my = self.packages."${system}";
                    chaotic = chaotic.packages.${system};
                    stable = import inputs.nixpkgs-stable {
                      inherit system;
                      config.allowUnfree = true;
                    };
                    un = import inputs.nixpkgs-un {
                      inherit system;
                      config.allowUnfree = true;
                    };
                  })
                ]
                ++ overlays;
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
        chaotic.nixosModules.default
        daeuniverse.nixosModules.daed
        lanzaboote.nixosModules.lanzaboote
        # nixos-hardware.nixosModules.common-cpu-amd-pstate
        # nixos-hardware.nixosModules.common-gpu-amd
        # nixos-hardware.nixosModules.common-pc-ssd
      ];
      overlays = [
        self.overlays.mutter
      ];
    });
}
