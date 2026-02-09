#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop-capybara
#
# Available versions:
#   2.22.1
#
# Usage:
#   rubocop-capybara { version = "2.22.1"; }
#   rubocop-capybara { }  # latest (2.22.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.22.1",
  git ? { },
}:
let
  versions = {
    "2.22.1" = import ./2.22.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rubocop-capybara: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rubocop-capybara: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
