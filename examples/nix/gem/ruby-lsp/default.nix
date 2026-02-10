#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-lsp
#
# Versions: 0.26.4, 0.26.5
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.26.5",
  git ? { },
}:
let
  versions = {
    "0.26.4" = import ./0.26.4 { inherit lib stdenv ruby; };
    "0.26.5" = import ./0.26.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ruby-lsp: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ruby-lsp: unknown version '${version}'")
