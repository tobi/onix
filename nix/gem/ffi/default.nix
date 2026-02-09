#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ffi
#
# Available versions:
#   1.17.2
#
# Usage:
#   ffi { version = "1.17.2"; }
#   ffi { }  # latest (1.17.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.17.2",
  git ? { },
}:
let
  versions = {
    "1.17.2" = import ./1.17.2 {
      inherit
        lib
        stdenv
        ruby
        pkgs
        ;
    };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ffi: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "ffi: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
