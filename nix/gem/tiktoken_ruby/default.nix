#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tiktoken_ruby
#
# Available versions:
#   0.0.15.1
#
# Usage:
#   tiktoken_ruby { version = "0.0.15.1"; }
#   tiktoken_ruby { }  # latest (0.0.15.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.0.15.1",
  git ? { },
}:
let
  versions = {
    "0.0.15.1" = import ./0.0.15.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "tiktoken_ruby: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "tiktoken_ruby: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
