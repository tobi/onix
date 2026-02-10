#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tiktoken_ruby
#
# Versions: 0.0.15.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.0.15.1",
  git ? { },
}:
let
  versions = {
    "0.0.15.1" = import ./0.0.15.1 { inherit lib stdenv ruby pkgs; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "tiktoken_ruby: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "tiktoken_ruby: unknown version '${version}'")
