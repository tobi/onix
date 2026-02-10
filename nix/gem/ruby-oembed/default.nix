#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-oembed
#
# Versions: 0.18.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.18.1",
  git ? { },
}:
let
  versions = {
    "0.18.1" = import ./0.18.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ruby-oembed: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ruby-oembed: unknown version '${version}'")
