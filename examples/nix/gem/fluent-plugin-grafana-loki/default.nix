#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fluent-plugin-grafana-loki
#
# Versions: 1.2.18, 1.2.19, 1.2.20
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.20",
  git ? { },
}:
let
  versions = {
    "1.2.18" = import ./1.2.18 { inherit lib stdenv ruby; };
    "1.2.19" = import ./1.2.19 { inherit lib stdenv ruby; };
    "1.2.20" = import ./1.2.20 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "fluent-plugin-grafana-loki: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "fluent-plugin-grafana-loki: unknown version '${version}'")
