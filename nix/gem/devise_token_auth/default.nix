#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# devise_token_auth
#
# Available versions:
#   1.2.5
#
# Usage:
#   devise_token_auth { version = "1.2.5"; }
#   devise_token_auth { }  # latest (1.2.5)
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
    or (throw "devise_token_auth: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "devise_token_auth: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
