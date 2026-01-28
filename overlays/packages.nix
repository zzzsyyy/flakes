{ inputs, self }:
final: prev:
let
  system = final.stdenv.hostPlatform.system;
in
{
  dae-unstable = inputs.daeuniverse.packages.${system}.dae-unstable;
  zen-browser = inputs.zen-browser.packages.${system}.twilight;
  noctalia-shell = inputs.noctalia.packages.${system}.default;
  my = self.packages.${system};
}
