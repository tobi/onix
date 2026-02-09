#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# azure-storage-ruby (git only)
#
# Available git revs:
#   9957cf899d33
#
# Usage:
#   azure-storage-ruby { git.rev = "9957cf899d33"; }
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? null,
  git ? { },
}:
let
  versions = { };

  gitRevs = {
    "9957cf899d33" = import ./git-9957cf899d33 { inherit lib stdenv ruby; };
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "azure-storage-ruby: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else if version != null then
  throw "azure-storage-ruby: no rubygems versions, only git revs: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}"
else
  throw "azure-storage-ruby: specify git.rev — available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}"
