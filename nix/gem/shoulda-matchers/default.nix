#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# shoulda-matchers
#
# Available versions:
#   5.3.0
#   7.0.1
#
# Usage:
#   shoulda-matchers { version = "7.0.1"; }
#   shoulda-matchers { }  # latest (7.0.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "7.0.1",
  git ? { },
}:
let
  versions = {
    "5.3.0" = import ./5.3.0 { inherit lib stdenv ruby; };
    "7.0.1" = import ./7.0.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "shoulda-matchers: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "shoulda-matchers: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
