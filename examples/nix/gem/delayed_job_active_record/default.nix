#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# delayed_job_active_record
#
# Versions: 4.1.9, 4.1.10, 4.1.11
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.1.11",
  git ? { },
}:
let
  versions = {
    "4.1.9" = import ./4.1.9 { inherit lib stdenv ruby; };
    "4.1.10" = import ./4.1.10 { inherit lib stdenv ruby; };
    "4.1.11" = import ./4.1.11 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "delayed_job_active_record: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "delayed_job_active_record: unknown version '${version}'")
