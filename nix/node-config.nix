# node-config.nix — node overlay loader
#
# Reads overlays/node/<name>.nix files and returns an attrset of per-package config.
# Each overlay is { pkgs } -> <deps list or config attrset>.
#
# Supported minimal contract:
#   { deps ? [], preInstall ? "", prePnpmInstall ? "", pnpmInstallFlags ? [] }
#   or shorthand list => { deps = <list>; }

{ pkgs, overlayDir }:

let
  inherit (pkgs) lib;

  overlayFiles = if builtins.pathExists overlayDir then builtins.readDir overlayDir else { };

  nixFiles = lib.filterAttrs (
    name: type: type == "regular" && lib.hasSuffix ".nix" name && !(lib.hasPrefix "_" name)
  ) overlayFiles;

  loadOverlay =
    filename:
    let
      name = lib.removeSuffix ".nix" filename;
      fn = import (overlayDir + "/${filename}");
      raw = fn { inherit pkgs; };
      config = if builtins.isList raw then { deps = raw; } else raw;
    in
    {
      inherit name;
      value = config;
    };

in
builtins.listToAttrs (map loadOverlay (builtins.attrNames nixFiles))
