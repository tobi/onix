#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fluent-plugin-elasticsearch
#
# Versions: 5.4.3, 5.4.4, 6.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.0.0",
  git ? { },
}:
let
  versions = {
    "5.4.3" = import ./5.4.3 { inherit lib stdenv ruby; };
    "5.4.4" = import ./5.4.4 { inherit lib stdenv ruby; };
    "6.0.0" = import ./6.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "fluent-plugin-elasticsearch: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "fluent-plugin-elasticsearch: unknown version '${version}'")
