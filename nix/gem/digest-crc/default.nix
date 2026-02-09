#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# digest-crc
#
# Available versions:
#   0.6.5
#
# Usage:
#   digest-crc { version = "0.6.5"; }
#   digest-crc { }  # latest (0.6.5)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.6.5",
  git ? { },
}:
let
  versions = {
    "0.6.5" = import ./0.6.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "digest-crc: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "digest-crc: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
