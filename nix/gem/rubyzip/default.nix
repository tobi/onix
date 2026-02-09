#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubyzip
#
# Available versions:
#   2.4.1
#   3.2.2
#
# Usage:
#   rubyzip { version = "3.2.2"; }
#   rubyzip { }  # latest (3.2.2)
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
    "2.4.1" = import ./2.4.1 { inherit lib stdenv ruby; };
    "3.2.2" = import ./3.2.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rubyzip: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rubyzip: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
