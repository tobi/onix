#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# dogstatsd-ruby
#
# Versions: 5.6.1, 5.6.6, 5.7.0, 5.7.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.7.1",
  git ? { },
}:
let
  versions = {
    "5.6.1" = import ./5.6.1 { inherit lib stdenv ruby; };
    "5.6.6" = import ./5.6.6 { inherit lib stdenv ruby; };
    "5.7.0" = import ./5.7.0 { inherit lib stdenv ruby; };
    "5.7.1" = import ./5.7.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "dogstatsd-ruby: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "dogstatsd-ruby: unknown version '${version}'")
