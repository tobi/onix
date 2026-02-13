# gem-config.nix — overlay loader
#
# Reads overlays/<name>.nix files and returns an attrset of gem configs.
# Each overlay is { pkgs, ruby, buildGem?, ... } -> <deps list or config attrset>.
#
# Returns: { gemName = { deps, extconfFlags, preBuild, ... }; ... }

{ pkgs, ruby, overlayDir, rubyDir ? null, buildGemFn ? null }:

let
  inherit (pkgs) lib;

  overlayFiles = if builtins.pathExists overlayDir
    then builtins.readDir overlayDir
    else {};

  nixFiles = lib.filterAttrs (name: type:
    type == "regular" && lib.hasSuffix ".nix" name && !(lib.hasPrefix "_" name)
  ) overlayFiles;

  # Helper: build a gem by name (latest version from rubyDir)
  buildGem = name:
    if buildGemFn != null then buildGemFn name
    else throw "buildGem not available — pass buildGemFn to gem-config.nix";

  loadOverlay = filename:
    let
      name = lib.removeSuffix ".nix" filename;
      fn = import (overlayDir + "/${filename}");
      # Pass all args the overlay might want; use ... in overlay to ignore extras
      args = { inherit pkgs ruby buildGem; };
      raw = fn args;
      # Normalize: list → { deps = list; }, attrset → pass through
      config = if builtins.isList raw then { deps = raw; } else raw;
    in
    { inherit name; value = config; };

in
builtins.listToAttrs (map loadOverlay (builtins.attrNames nixFiles))
