#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# capybara-playwright-driver
#
# Available versions:
#   0.5.7
#
# Usage:
#   capybara-playwright-driver { version = "0.5.7"; }
#   capybara-playwright-driver { }  # latest (0.5.7)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.5.7",
  git ? { },
}:
let
  versions = {
    "0.5.7" = import ./0.5.7 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "capybara-playwright-driver: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "capybara-playwright-driver: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
