#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# factory_bot
#
# Versions: 6.2.1, 6.4.5, 6.5.4, 6.5.5, 6.5.6
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.5.6",
  git ? { },
}:
let
  versions = {
    "6.2.1" = import ./6.2.1 { inherit lib stdenv ruby; };
    "6.4.5" = import ./6.4.5 { inherit lib stdenv ruby; };
    "6.5.4" = import ./6.5.4 { inherit lib stdenv ruby; };
    "6.5.5" = import ./6.5.5 { inherit lib stdenv ruby; };
    "6.5.6" = import ./6.5.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "factory_bot: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "factory_bot: unknown version '${version}'")
