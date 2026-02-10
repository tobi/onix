#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# discourse-emojis
#
# Versions: 1.0.44
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.44",
  git ? { },
}:
let
  versions = {
    "1.0.44" = import ./1.0.44 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "discourse-emojis: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "discourse-emojis: unknown version '${version}'")
