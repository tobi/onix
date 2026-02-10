#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# net-imap
#
# Versions: 0.4.10, 0.4.20, 0.5.5, 0.5.12, 0.6.0, 0.6.1, 0.6.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.6.2",
  git ? { },
}:
let
  versions = {
    "0.4.10" = import ./0.4.10 { inherit lib stdenv ruby; };
    "0.4.20" = import ./0.4.20 { inherit lib stdenv ruby; };
    "0.5.5" = import ./0.5.5 { inherit lib stdenv ruby; };
    "0.5.12" = import ./0.5.12 { inherit lib stdenv ruby; };
    "0.6.0" = import ./0.6.0 { inherit lib stdenv ruby; };
    "0.6.1" = import ./0.6.1 { inherit lib stdenv ruby; };
    "0.6.2" = import ./0.6.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "net-imap: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "net-imap: unknown version '${version}'")
