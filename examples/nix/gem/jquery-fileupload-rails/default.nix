#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# jquery-fileupload-rails
#
# Versions: 0.4.7
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.4.7",
  git ? { },
}:
let
  versions = {
    "0.4.7" = import ./0.4.7 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "jquery-fileupload-rails: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "jquery-fileupload-rails: unknown version '${version}'")
