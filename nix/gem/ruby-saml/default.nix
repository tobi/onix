#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-saml
#
# Available versions:
#   1.18.1
#
# Usage:
#   ruby-saml { version = "1.18.1"; }
#   ruby-saml { }  # latest (1.18.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.18.1",
  git ? { },
}:
let
  versions = {
    "1.18.1" = import ./1.18.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ruby-saml: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "ruby-saml: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
