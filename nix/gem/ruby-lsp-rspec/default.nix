#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-lsp-rspec
#
# Available versions:
#   0.1.28
#
# Usage:
#   ruby-lsp-rspec { version = "0.1.28"; }
#   ruby-lsp-rspec { }  # latest (0.1.28)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.1.28",
  git ? { },
}:
let
  versions = {
    "0.1.28" = import ./0.1.28 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ruby-lsp-rspec: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "ruby-lsp-rspec: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
