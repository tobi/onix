# gem-config.nix — overlay loader
#
# Reads overlays/<name>.nix files and returns an attrset of gem configs.
# Each overlay is { pkgs, ruby } -> <deps list or config attrset>.
#
# Returns: { gemName = { deps, extconfFlags, beforeBuild, ... }; ... }

{ pkgs, ruby, overlayDir }:

let
  inherit (pkgs) lib;

  overlayFiles = if builtins.pathExists overlayDir
    then builtins.readDir overlayDir
    else {};

  nixFiles = lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".nix" name) overlayFiles;

  loadOverlay = filename:
    let
      name = lib.removeSuffix ".nix" filename;
      raw = import (overlayDir + "/${filename}") { inherit pkgs ruby; };
      # Normalize: list → { deps = list; }, attrset → pass through
      config = if builtins.isList raw then { deps = raw; } else raw;
    in
    { inherit name; value = config; };

in
builtins.listToAttrs (map loadOverlay (builtins.attrNames nixFiles))
