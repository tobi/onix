#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# uri_template
#
# Versions: 0.5.3, 0.6.0, 0.7.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.7.0",
  git ? { },
}:
let
  versions = {
    "0.5.3" = import ./0.5.3 { inherit lib stdenv ruby; };
    "0.6.0" = import ./0.6.0 { inherit lib stdenv ruby; };
    "0.7.0" = import ./0.7.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "uri_template: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "uri_template: unknown version '${version}'")
