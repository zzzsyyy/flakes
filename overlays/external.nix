# External overlays from flake inputs
{ inputs, lib }:
lib.composeManyExtensions [
  inputs.niri.overlays.niri
  inputs.neovim-nightly-overlay.overlays.default
  inputs.nix-cachyos-kernel.overlays.pinned
  inputs.nvfetcher.overlays.default
  inputs.llm-agents.overlays.default
]
