#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-openai
#
# Available versions:
#   7.3.1
#
# Usage:
#   ruby-openai { version = "7.3.1"; }
#   ruby-openai { }  # latest (7.3.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "7.3.1",
  git ? { },
}:
let
  versions = {
    "7.3.1" = import ./7.3.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ruby-openai: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "ruby-openai: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
