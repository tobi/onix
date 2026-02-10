#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fluent-plugin-s3
#
# Versions: 1.8.1, 1.8.2, 1.8.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.8.3",
  git ? { },
}:
let
  versions = {
    "1.8.1" = import ./1.8.1 { inherit lib stdenv ruby; };
    "1.8.2" = import ./1.8.2 { inherit lib stdenv ruby; };
    "1.8.3" = import ./1.8.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "fluent-plugin-s3: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "fluent-plugin-s3: unknown version '${version}'")
