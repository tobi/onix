#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# stripe-ruby-mock
#
# Versions: 3.1.0.rc3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.1.0.rc3",
  git ? { },
}:
let
  versions = {
    "3.1.0.rc3" = import ./3.1.0.rc3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "stripe-ruby-mock: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "stripe-ruby-mock: unknown version '${version}'")
