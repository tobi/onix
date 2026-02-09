#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rspec-rails
#
# Available versions:
#   7.0.1
#   8.0.2
#
# Usage:
#   rspec-rails { version = "8.0.2"; }
#   rspec-rails { }  # latest (8.0.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "8.0.2",
  git ? { },
}:
let
  versions = {
    "7.0.1" = import ./7.0.1 { inherit lib stdenv ruby; };
    "8.0.2" = import ./8.0.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rspec-rails: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rspec-rails: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
