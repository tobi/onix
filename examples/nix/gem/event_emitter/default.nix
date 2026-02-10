#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# event_emitter
#
# Versions: 0.2.6
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.2.6",
  git ? { },
}:
let
  versions = {
    "0.2.6" = import ./0.2.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "event_emitter: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "event_emitter: unknown version '${version}'")
