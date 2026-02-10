#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# devise-secure_password (git only)
#
# Available git revs:
#   adcc85fe1bab
#
# Usage:
#   devise-secure_password { git.rev = "adcc85fe1bab"; }
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? null,
  git ? { },
}:
let
  versions = { };

  gitRevs = {
    "adcc85fe1bab" = import ./git-adcc85fe1bab { inherit lib stdenv ruby; };
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "devise-secure_password: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else if version != null then
  throw "devise-secure_password: no rubygems versions, only git revs: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}"
else
  throw "devise-secure_password: specify git.rev — available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}"
