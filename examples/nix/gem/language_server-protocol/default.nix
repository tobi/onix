#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# language_server-protocol
#
# Versions: 3.17.0.3, 3.17.0.4, 3.17.0.5
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.17.0.5",
  git ? { },
}:
let
  versions = {
    "3.17.0.3" = import ./3.17.0.3 { inherit lib stdenv ruby; };
    "3.17.0.4" = import ./3.17.0.4 { inherit lib stdenv ruby; };
    "3.17.0.5" = import ./3.17.0.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "language_server-protocol: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "language_server-protocol: unknown version '${version}'")
