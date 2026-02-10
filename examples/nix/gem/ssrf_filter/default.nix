#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ssrf_filter
#
# Versions: 1.1.2, 1.2.0, 1.3.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.3.0",
  git ? { },
}:
let
  versions = {
    "1.1.2" = import ./1.1.2 { inherit lib stdenv ruby; };
    "1.2.0" = import ./1.2.0 { inherit lib stdenv ruby; };
    "1.3.0" = import ./1.3.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ssrf_filter: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ssrf_filter: unknown version '${version}'")
