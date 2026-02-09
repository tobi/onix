#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-lsp-rails
#
# Available versions:
#   0.4.8
#
# Usage:
#   ruby-lsp-rails { version = "0.4.8"; }
#   ruby-lsp-rails { }  # latest (0.4.8)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.4.8",
  git ? { },
}:
let
  versions = {
    "0.4.8" = import ./0.4.8 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ruby-lsp-rails: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "ruby-lsp-rails: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
