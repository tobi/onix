#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# webpush
#
# Versions: 1.1.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.1.0",
  git ? { },
}:
let
  versions = {
    "1.1.0" = import ./1.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
    "9631ac63045c" = import ./git-9631ac63045c { inherit lib stdenv ruby; };
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "webpush: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "webpush: unknown version '${version}'")
