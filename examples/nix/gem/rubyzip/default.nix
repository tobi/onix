#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubyzip
#
# Versions: 2.3.2, 2.4.1, 3.0.0.rc2, 3.2.0, 3.2.1, 3.2.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.2.2",
  git ? { },
}:
let
  versions = {
    "2.3.2" = import ./2.3.2 { inherit lib stdenv ruby; };
    "2.4.1" = import ./2.4.1 { inherit lib stdenv ruby; };
    "3.0.0.rc2" = import ./3.0.0.rc2 { inherit lib stdenv ruby; };
    "3.2.0" = import ./3.2.0 { inherit lib stdenv ruby; };
    "3.2.1" = import ./3.2.1 { inherit lib stdenv ruby; };
    "3.2.2" = import ./3.2.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rubyzip: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rubyzip: unknown version '${version}'")
