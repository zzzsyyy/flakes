default:
  @just --summary --unsorted --justfile {{justfile()}}

alias u:=update
alias s:=switch
alias m:=metadata

metadata:
  nix flake metadata

update:
  nix flake update

fmt:
  nixpkgs-fmt ./

switch:
  sudo nixos-rebuild switch --flake .#laptop -L

test:
  sudo nixos-rebuild test --flake .#laptop -L

gc:
  sudo nix-collect-garbage --delete-older-than 5d
  sudo nix store gc --debug

diff:
  nix profile diff-closures --profile /nix/var/nix/profiles/system

show:
  nix flake show
