#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# html_truncator
#
# Versions: 0.4.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.4.2",
  git ? { },
}:
let
  versions = {
    "0.4.2" = import ./0.4.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "html_truncator: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "html_truncator: unknown version '${version}'")
