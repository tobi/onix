#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# playwright-ruby-client
#
# Versions: 1.57.0, 1.57.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.57.1",
  git ? { },
}:
let
  versions = {
    "1.57.0" = import ./1.57.0 { inherit lib stdenv ruby; };
    "1.57.1" = import ./1.57.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "playwright-ruby-client: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "playwright-ruby-client: unknown version '${version}'")
