#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opensearch-ruby
#
# Versions: 3.4.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.4.0",
  git ? { },
}:
let
  versions = {
    "3.4.0" = import ./3.4.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "opensearch-ruby: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "opensearch-ruby: unknown version '${version}'")
