#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# net-imap
#
# Available versions:
#   0.4.20
#   0.5.12
#   0.6.2
#
# Usage:
#   net-imap { version = "0.6.2"; }
#   net-imap { }  # latest (0.6.2)
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
    "0.4.20" = import ./0.4.20 { inherit lib stdenv ruby; };
    "0.5.12" = import ./0.5.12 { inherit lib stdenv ruby; };
    "0.6.2" = import ./0.6.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "net-imap: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "net-imap: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
