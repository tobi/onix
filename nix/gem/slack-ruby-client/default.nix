#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# slack-ruby-client
#
# Versions: 2.7.0, 3.0.0, 3.1.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.1.0",
  git ? { },
}:
let
  versions = {
    "2.7.0" = import ./2.7.0 { inherit lib stdenv ruby; };
    "3.0.0" = import ./3.0.0 { inherit lib stdenv ruby; };
    "3.1.0" = import ./3.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "slack-ruby-client: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "slack-ruby-client: unknown version '${version}'")
