#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# bouncy-castle-java
#
# Versions: 1.5.0147
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.5.0147",
  git ? { },
}:
let
  versions = {
    "1.5.0147" = import ./1.5.0147 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "bouncy-castle-java: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "bouncy-castle-java: unknown version '${version}'")
