#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# gmail_xoauth
#
# Versions: 0.4.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.4.3",
  git ? { },
}:
let
  versions = {
    "0.4.3" = import ./0.4.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "gmail_xoauth: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "gmail_xoauth: unknown version '${version}'")
