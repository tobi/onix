#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rails-html-sanitizer
#
# Versions: 1.6.0, 1.6.1, 1.6.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.6.2",
  git ? { },
}:
let
  versions = {
    "1.6.0" = import ./1.6.0 { inherit lib stdenv ruby; };
    "1.6.1" = import ./1.6.1 { inherit lib stdenv ruby; };
    "1.6.2" = import ./1.6.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rails-html-sanitizer: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rails-html-sanitizer: unknown version '${version}'")
