#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# capybara-screenshot
#
# Versions: 1.0.24, 1.0.25, 1.0.26
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.26",
  git ? { },
}:
let
  versions = {
    "1.0.24" = import ./1.0.24 { inherit lib stdenv ruby; };
    "1.0.25" = import ./1.0.25 { inherit lib stdenv ruby; };
    "1.0.26" = import ./1.0.26 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "capybara-screenshot: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "capybara-screenshot: unknown version '${version}'")
