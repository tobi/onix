#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# capybara-playwright-driver
#
# Versions: 0.5.7
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
    or (throw "capybara-playwright-driver: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "capybara-playwright-driver: unknown version '${version}'")
