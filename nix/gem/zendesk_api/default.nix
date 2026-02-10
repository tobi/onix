#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# zendesk_api
#
# Versions: 1.38.0.rc1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.38.0.rc1",
  git ? { },
}:
let
  versions = {
    "1.38.0.rc1" = import ./1.38.0.rc1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "zendesk_api: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "zendesk_api: unknown version '${version}'")
