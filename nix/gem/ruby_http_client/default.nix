#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby_http_client
#
# Versions: 3.5.4, 3.5.5, 3.6.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.6.0",
  git ? { },
}:
let
  versions = {
    "3.5.4" = import ./3.5.4 { inherit lib stdenv ruby; };
    "3.5.5" = import ./3.5.5 { inherit lib stdenv ruby; };
    "3.6.0" = import ./3.6.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ruby_http_client: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ruby_http_client: unknown version '${version}'")
