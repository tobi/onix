#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# datadog-ruby_core_source
#
# Versions: 3.4.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.4.1",
  git ? { },
}:
let
  versions = {
    "3.4.1" = import ./3.4.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "datadog-ruby_core_source: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "datadog-ruby_core_source: unknown version '${version}'")
