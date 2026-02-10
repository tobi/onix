#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# twilio-ruby
#
# Versions: 7.6.0, 7.9.1, 7.10.0, 7.10.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "7.10.1",
  git ? { },
}:
let
  versions = {
    "7.6.0" = import ./7.6.0 { inherit lib stdenv ruby; };
    "7.9.1" = import ./7.9.1 { inherit lib stdenv ruby; };
    "7.10.0" = import ./7.10.0 { inherit lib stdenv ruby; };
    "7.10.1" = import ./7.10.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "twilio-ruby: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "twilio-ruby: unknown version '${version}'")
