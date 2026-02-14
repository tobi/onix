{ pkgs ? import <nixpkgs> { config = {}; overlays = []; }, nodejs ? pkgs.nodejs_22 }:
let
  project = import ../../nix/tsdown-starter.nix { inherit pkgs nodejs; };
in project.devShell {}
