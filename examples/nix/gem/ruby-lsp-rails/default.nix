#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-lsp-rails
#
# Versions: 0.4.8
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.4.8",
  git ? { },
}:
let
  versions = {
    "0.4.8" = import ./0.4.8 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ruby-lsp-rails: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ruby-lsp-rails: unknown version '${version}'")
