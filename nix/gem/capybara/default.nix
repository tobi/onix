#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# capybara
#
# Available versions:
#   3.40.0
#
# Usage:
#   capybara { version = "3.40.0"; }
#   capybara { }  # latest (3.40.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.40.0",
  git ? { },
}:
let
  versions = {
    "3.40.0" = import ./3.40.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "capybara: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "capybara: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
