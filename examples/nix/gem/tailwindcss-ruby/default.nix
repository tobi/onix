#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tailwindcss-ruby
#
# Versions: 3.4.17, 3.4.19, 4.1.18
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.1.18",
  git ? { },
}:
let
  versions = {
    "3.4.17" = import ./3.4.17 { inherit lib stdenv ruby; };
    "3.4.19" = import ./3.4.19 { inherit lib stdenv ruby; };
    "4.1.18" = import ./4.1.18 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "tailwindcss-ruby: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "tailwindcss-ruby: unknown version '${version}'")
