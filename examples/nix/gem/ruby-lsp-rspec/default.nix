#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-lsp-rspec
#
# Versions: 0.1.28
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.1.28",
  git ? { },
}:
let
  versions = {
    "0.1.28" = import ./0.1.28 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ruby-lsp-rspec: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ruby-lsp-rspec: unknown version '${version}'")
