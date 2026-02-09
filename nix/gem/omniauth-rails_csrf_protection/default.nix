#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# omniauth-rails_csrf_protection
#
# Available versions:
#   1.0.2
#
# Usage:
#   omniauth-rails_csrf_protection { version = "1.0.2"; }
#   omniauth-rails_csrf_protection { }  # latest (1.0.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.2",
  git ? { },
}:
let
  versions = {
    "1.0.2" = import ./1.0.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "omniauth-rails_csrf_protection: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "omniauth-rails_csrf_protection: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
