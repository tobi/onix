#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# concurrent-ruby
#
# Available versions:
#   1.3.5
#   1.3.6
#
# Usage:
#   concurrent-ruby { version = "1.3.6"; }
#   concurrent-ruby { }  # latest (1.3.6)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.3.6",
  git ? { },
}:
let
  versions = {
    "1.3.5" = import ./1.3.5 { inherit lib stdenv ruby; };
    "1.3.6" = import ./1.3.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "concurrent-ruby: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "concurrent-ruby: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
