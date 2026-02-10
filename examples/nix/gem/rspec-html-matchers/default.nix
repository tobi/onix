#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rspec-html-matchers
#
# Versions: 0.10.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.10.0",
  git ? { },
}:
let
  versions = {
    "0.10.0" = import ./0.10.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rspec-html-matchers: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rspec-html-matchers: unknown version '${version}'")
