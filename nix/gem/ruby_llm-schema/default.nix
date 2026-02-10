#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby_llm-schema
#
# Versions: 0.2.5
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.2.5",
  git ? { },
}:
let
  versions = {
    "0.2.5" = import ./0.2.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ruby_llm-schema: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ruby_llm-schema: unknown version '${version}'")
