#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# digest-xxhash
#
# Available versions:
#   0.2.9
#
# Usage:
#   digest-xxhash { version = "0.2.9"; }
#   digest-xxhash { }  # latest (0.2.9)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.2.9",
  git ? { },
}:
let
  versions = {
    "0.2.9" = import ./0.2.9 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "digest-xxhash: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "digest-xxhash: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
