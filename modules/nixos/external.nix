{ inputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.preservation.nixosModules.default
    inputs.ucodenix.nixosModules.default
    inputs.vaultix.nixosModules.default
  ];
}
