{ inputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.preservation.nixosModules.default
    inputs.daeuniverse.nixosModules.dae
    inputs.nur.modules.nixos.default
    inputs.ucodenix.nixosModules.default
    inputs.vaultix.nixosModules.default
  ];
}
