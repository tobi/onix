#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# playwright-ruby-client
#
# Available versions:
#   1.57.0
#
# Usage:
#   playwright-ruby-client { version = "1.57.0"; }
#   playwright-ruby-client { }  # latest (1.57.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.57.0",
  git ? { },
}:
let
  versions = {
    "1.57.0" = import ./1.57.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "playwright-ruby-client: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "playwright-ruby-client: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
