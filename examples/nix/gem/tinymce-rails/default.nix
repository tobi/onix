#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tinymce-rails
#
# Versions: 6.8.6.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.8.6.1",
  git ? { },
}:
let
  versions = {
    "6.8.6.1" = import ./6.8.6.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "tinymce-rails: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "tinymce-rails: unknown version '${version}'")
