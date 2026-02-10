#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# delayed_job
#
# Versions: 4.1.12, 4.1.13, 4.2.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.2.0",
  git ? { },
}:
let
  versions = {
    "4.1.12" = import ./4.1.12 { inherit lib stdenv ruby; };
    "4.1.13" = import ./4.1.13 { inherit lib stdenv ruby; };
    "4.2.0" = import ./4.2.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "delayed_job: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "delayed_job: unknown version '${version}'")
