{ self, system, nixpkgs-stable,... }:
{
  flake.overlay.default = (import ../overlays)
    ++ [
    (final: prev: {
      my = self.packages."${system}";
      stable = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
    })
  ];
}
