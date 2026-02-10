#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-openai
#
# Versions: 7.3.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "7.3.1",
  git ? { },
}:
let
  versions = {
    "7.3.1" = import ./7.3.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ruby-openai: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ruby-openai: unknown version '${version}'")
