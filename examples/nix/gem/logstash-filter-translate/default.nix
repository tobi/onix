#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# logstash-filter-translate
#
# Versions: 3.4.2, 3.4.3, 3.5.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.5.0",
  git ? { },
}:
let
  versions = {
    "3.4.2" = import ./3.4.2 { inherit lib stdenv ruby; };
    "3.4.3" = import ./3.4.3 { inherit lib stdenv ruby; };
    "3.5.0" = import ./3.5.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "logstash-filter-translate: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "logstash-filter-translate: unknown version '${version}'")
