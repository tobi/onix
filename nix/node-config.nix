# node-config.nix — node overlay loader
#
# Reads overlays/node/<name>.nix files and returns an attrset of per-package config.
# Each overlay is { pkgs } -> <deps list or config attrset>.
#
# Supported contract:
#   { deps ? [], preBuild ? "", postBuild ? "", buildPhase ? "", postInstall ? "", installFlags ? [] }
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
      oldKeys = [
        "preInstall"
        "prePnpmInstall"
        "pnpmInstallFlags"
      ];
      allowedKeys = [
        "deps"
        "preBuild"
        "postBuild"
        "buildPhase"
        "postInstall"
        "installFlags"
      ];
      configKeys =
        if builtins.isAttrs config then
          builtins.attrNames config
        else
          throw "Node overlay ${name}.nix must return a list or attrset.";
      detectedOld = lib.filter (key: builtins.elem key configKeys) oldKeys;
      unknownKeys = lib.filter (key: !(builtins.elem key allowedKeys)) configKeys;
    in
    if detectedOld != [ ] then
      throw ''
        Node overlay ${name}.nix uses deprecated key(s): ${lib.concatStringsSep ", " detectedOld}
        Use the clean-break contract: deps, preBuild, postBuild, buildPhase, postInstall, installFlags
      ''
    else if unknownKeys != [ ] then
      throw "Node overlay ${name}.nix has unsupported key(s): ${lib.concatStringsSep ", " unknownKeys}"
    else
      {
        inherit name;
        value = config;
      };

in
builtins.listToAttrs (map loadOverlay (builtins.attrNames nixFiles))
