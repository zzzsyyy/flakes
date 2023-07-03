{
  self,
  inputs,
  ...
}: let
  username = "zzzsy";

  inherit (inputs) home-manager nixpkgs;

  inherit (nixpkgs.lib) attrValues;

  mkHost = {
    hostName,
    system,
    modules,
    overlays ? [self.overlays.default],
  }: {
    ${hostName} = nixpkgs.lib.nixosSystem {
      inherit system;

      modules =
        [
          {
            nixpkgs = {inherit overlays;};

            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              sharedModules = attrValues self.hmModules;
            };
            networking.hostName = hostName;
          }

          home-manager.nixosModules.home-manager
          ../host/common
          ../host/${hostName}
          (import ../home username)
        ]
        ++ (attrValues self.nixosModules)
        ++ modules;
      specialArgs = {inherit inputs;};
    };
  };
in {
  flake.nixosConfigurations =
    (mkHost {
      system = "x86_64-linux";
      hostName = "laptop";
      # modules = with inputs; [
      #   nixos-hardware.nixosModules.common-cpu-amd-pstate
      #   nixos-hardware.nixosModules.common-gpu-amd
      #   nixos-hardware.nixosModules.common-pc-ssd
      # ];
    });
}
