#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mustermann
#
# Versions: 3.0.2, 3.0.3, 3.0.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.0.4",
  git ? { },
}:
let
  versions = {
    "3.0.2" = import ./3.0.2 { inherit lib stdenv ruby; };
    "3.0.3" = import ./3.0.3 { inherit lib stdenv ruby; };
    "3.0.4" = import ./3.0.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mustermann: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "mustermann: unknown version '${version}'")
