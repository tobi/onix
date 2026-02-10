#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# multipart-post
#
# Versions: 2.2.3, 2.3.0, 2.4.0, 2.4.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.4.1",
  git ? { },
}:
let
  versions = {
    "2.2.3" = import ./2.2.3 { inherit lib stdenv ruby; };
    "2.3.0" = import ./2.3.0 { inherit lib stdenv ruby; };
    "2.4.0" = import ./2.4.0 { inherit lib stdenv ruby; };
    "2.4.1" = import ./2.4.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "multipart-post: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "multipart-post: unknown version '${version}'")
