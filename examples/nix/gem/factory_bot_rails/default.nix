#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# factory_bot_rails
#
# Versions: 6.2.0, 6.4.3, 6.4.4, 6.5.0, 6.5.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.5.1",
  git ? { },
}:
let
  versions = {
    "6.2.0" = import ./6.2.0 { inherit lib stdenv ruby; };
    "6.4.3" = import ./6.4.3 { inherit lib stdenv ruby; };
    "6.4.4" = import ./6.4.4 { inherit lib stdenv ruby; };
    "6.5.0" = import ./6.5.0 { inherit lib stdenv ruby; };
    "6.5.1" = import ./6.5.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "factory_bot_rails: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "factory_bot_rails: unknown version '${version}'")
