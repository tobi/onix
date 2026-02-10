#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# devise_token_auth
#
# Versions: 1.2.5
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.5",
  git ? { },
}:
let
  versions = {
    "1.2.5" = import ./1.2.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "devise_token_auth: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "devise_token_auth: unknown version '${version}'")
