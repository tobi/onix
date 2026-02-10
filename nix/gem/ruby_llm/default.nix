#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby_llm
#
# Versions: 1.8.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.8.2",
  git ? { },
}:
let
  versions = {
    "1.8.2" = import ./1.8.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ruby_llm: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ruby_llm: unknown version '${version}'")
