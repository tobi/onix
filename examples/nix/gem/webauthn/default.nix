#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# webauthn
#
# Versions: 3.4.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.4.3",
  git ? { },
}:
let
  versions = {
    "3.4.3" = import ./3.4.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "webauthn: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "webauthn: unknown version '${version}'")
