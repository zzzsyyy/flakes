{ self, inputs, ... }:
let
  username = "zzzsy";

  inherit (inputs)
    home-manager
    nixpkgs
    preservation
    sops-nix
    chaotic
    nixos-hardware
    nvfetcher
    daeuniverse
    #ghostty
    # vaultix
    zen-browser
    niri
    neovim-nightly-overlay
    nur
    #stylix
    ;

  inherit (nixpkgs.lib) attrValues;
  mkHost =
    {
      hostName,
      system,
      modules,
      overlays ? [ nvfetcher.overlays.default ],
    }:
    {
      ${hostName} = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              sharedModules = attrValues self.hmModules;
            };
            nixpkgs = {
              overlays = [
                (final: prev: {
                  dae-unstable = daeuniverse.packages.${system}.dae-unstable;
                  zen-browser = zen-browser.packages."${system}".twilight;
                  nvfetcher-test = nvfetcher.packages.${system}.default;
                  my = self.packages."${system}";
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
        specialArgs = {
          inherit inputs self;
        };
      };
    };
in
{
  flake.nixosConfigurations = (
    mkHost {
      system = "x86_64-linux";
      hostName = "laptop";
      modules = [
        preservation.nixosModules.default
        sops-nix.nixosModules.sops
        chaotic.nixosModules.default
        daeuniverse.nixosModules.dae
        nur.modules.nixos.default
        # stylix.nixosModules.stylix
        nixos-hardware.nixosModules.common-cpu-amd-pstate
        nixos-hardware.nixosModules.common-gpu-amd
      ];
      overlays = [
        self.overlays.mutter
        niri.overlays.niri
        nur.overlays.default
        neovim-nightly-overlay.overlays.default
      ];
    }
  );
}
