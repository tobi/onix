#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# dotenv-rails
#
# Available versions:
#   3.1.2
#
# Usage:
#   dotenv-rails { version = "3.1.2"; }
#   dotenv-rails { }  # latest (3.1.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.1.2",
  git ? { },
}:
let
  versions = {
    "3.1.2" = import ./3.1.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "dotenv-rails: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "dotenv-rails: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
