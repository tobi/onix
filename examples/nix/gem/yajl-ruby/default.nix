#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# yajl-ruby
#
# Versions: 1.4.1, 1.4.2, 1.4.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.4.3",
  git ? { },
}:
let
  versions = {
    "1.4.1" = import ./1.4.1 { inherit lib stdenv ruby; };
    "1.4.2" = import ./1.4.2 { inherit lib stdenv ruby; };
    "1.4.3" = import ./1.4.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "yajl-ruby: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "yajl-ruby: unknown version '${version}'")
