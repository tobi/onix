#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# discourse_ai-tokenizers
#
# Versions: 0.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.4",
  git ? { },
}:
let
  versions = {
    "0.4" = import ./0.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "discourse_ai-tokenizers: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "discourse_ai-tokenizers: unknown version '${version}'")
