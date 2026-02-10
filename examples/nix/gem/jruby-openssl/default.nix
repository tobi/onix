#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# jruby-openssl
#
# Versions: 0.9.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.9.4",
  git ? { },
}:
let
  versions = {
    "0.9.4" = import ./0.9.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "jruby-openssl: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "jruby-openssl: unknown version '${version}'")
