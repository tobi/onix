#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# datadog-ruby_core_source
#
# Available versions:
#   3.4.1
#
# Usage:
#   datadog-ruby_core_source { version = "3.4.1"; }
#   datadog-ruby_core_source { }  # latest (3.4.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.4.1",
  git ? { },
}:
let
  versions = {
    "3.4.1" = import ./3.4.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "datadog-ruby_core_source: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "datadog-ruby_core_source: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
