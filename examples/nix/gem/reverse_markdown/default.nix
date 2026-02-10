#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# reverse_markdown
#
# Versions: 2.1.1, 3.0.0, 3.0.1, 3.0.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.0.2",
  git ? { },
}:
let
  versions = {
    "2.1.1" = import ./2.1.1 { inherit lib stdenv ruby; };
    "3.0.0" = import ./3.0.0 { inherit lib stdenv ruby; };
    "3.0.1" = import ./3.0.1 { inherit lib stdenv ruby; };
    "3.0.2" = import ./3.0.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "reverse_markdown: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "reverse_markdown: unknown version '${version}'")
