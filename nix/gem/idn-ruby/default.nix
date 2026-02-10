#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# idn-ruby
#
# Versions: 0.1.5
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.1.5",
  git ? { },
}:
let
  versions = {
    "0.1.5" = import ./0.1.5 { inherit lib stdenv ruby pkgs; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "idn-ruby: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "idn-ruby: unknown version '${version}'")
