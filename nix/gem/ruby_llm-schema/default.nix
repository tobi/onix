#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby_llm-schema
#
# Available versions:
#   0.2.5
#
# Usage:
#   ruby_llm-schema { version = "0.2.5"; }
#   ruby_llm-schema { }  # latest (0.2.5)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.2.5",
  git ? { },
}:
let
  versions = {
    "0.2.5" = import ./0.2.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ruby_llm-schema: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "ruby_llm-schema: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
