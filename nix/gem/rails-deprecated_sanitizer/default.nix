#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rails-deprecated_sanitizer
#
# Versions: 1.0.2, 1.0.3, 1.0.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.4",
  git ? { },
}:
let
  versions = {
    "1.0.2" = import ./1.0.2 { inherit lib stdenv ruby; };
    "1.0.3" = import ./1.0.3 { inherit lib stdenv ruby; };
    "1.0.4" = import ./1.0.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rails-deprecated_sanitizer: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rails-deprecated_sanitizer: unknown version '${version}'")
