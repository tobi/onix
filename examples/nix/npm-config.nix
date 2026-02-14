# npm-config.nix — overlay loader for npm packages
#
# Reads overlays/<name>.nix files and returns an attrset of package configs.
# Each overlay is { pkgs, nodejs, buildPackage?, ... } -> <deps list or config attrset>.
#
# Returns: { pkgName = { deps, buildFlags, beforeBuild, ... }; ... }

{ pkgs, nodejs, overlayDir, nodeDir ? null, buildPackageFn ? null }:

let
  inherit (pkgs) lib;

  overlayFiles = if builtins.pathExists overlayDir
    then builtins.readDir overlayDir
    else {};

  nixFiles = lib.filterAttrs (name: type:
    type == "regular" && lib.hasSuffix ".nix" name && !(lib.hasPrefix "_" name)
  ) overlayFiles;

  # Helper: build a package by name (latest version from nodeDir)
  buildPackage = name:
    if buildPackageFn != null then buildPackageFn name
    else throw "buildPackage not available — pass buildPackageFn to npm-config.nix";

  loadOverlay = filename:
    let
      name = lib.removeSuffix ".nix" filename;
      fn = import (overlayDir + "/${filename}");
      # Pass all args the overlay might want; use ... in overlay to ignore extras
      args = { inherit pkgs nodejs buildPackage; };
      raw = fn args;
      # Normalize: list → { deps = list; }, attrset → pass through
      config = if builtins.isList raw then { deps = raw; } else raw;
    in
    { inherit name; value = config; };

in
builtins.listToAttrs (map loadOverlay (builtins.attrNames nixFiles))
