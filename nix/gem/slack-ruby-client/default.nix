#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# slack-ruby-client
#
# Available versions:
#   2.7.0
#
# Usage:
#   slack-ruby-client { version = "2.7.0"; }
#   slack-ruby-client { }  # latest (2.7.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.7.0",
  git ? { },
}:
let
  versions = {
    "2.7.0" = import ./2.7.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "slack-ruby-client: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "slack-ruby-client: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
