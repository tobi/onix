#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# better_html
#
# Versions: 2.0.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.0.2",
  git ? { },
}:
let
  versions = {
    "2.0.2" = import ./2.0.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "better_html: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "better_html: unknown version '${version}'")
