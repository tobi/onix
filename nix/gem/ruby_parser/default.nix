#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby_parser
#
# Versions: 3.20.0, 3.21.0, 3.21.1, 3.22.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.22.0",
  git ? { },
}:
let
  versions = {
    "3.20.0" = import ./3.20.0 { inherit lib stdenv ruby; };
    "3.21.0" = import ./3.21.0 { inherit lib stdenv ruby; };
    "3.21.1" = import ./3.21.1 { inherit lib stdenv ruby; };
    "3.22.0" = import ./3.22.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ruby_parser: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ruby_parser: unknown version '${version}'")
