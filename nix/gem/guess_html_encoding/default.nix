#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# guess_html_encoding
#
# Available versions:
#   0.0.11
#
# Usage:
#   guess_html_encoding { version = "0.0.11"; }
#   guess_html_encoding { }  # latest (0.0.11)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.0.11",
  git ? { },
}:
let
  versions = {
    "0.0.11" = import ./0.0.11 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "guess_html_encoding: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "guess_html_encoding: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
