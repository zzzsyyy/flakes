{ inputs, lib, ... }:
let
  inherit (lib) mkOption types;
in
rec {

  enabled = {
    enable = true;
  };

  disabled = {
    enable = false;
  };

  infuse = (import inputs.infuse.outPath { inherit lib; }).v1.infuse;
}
