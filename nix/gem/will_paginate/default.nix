#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# will_paginate
#
# Versions: 3.3.1, 4.0.0, 4.0.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.0.1",
  git ? { },
}:
let
  versions = {
    "3.3.1" = import ./3.3.1 { inherit lib stdenv ruby; };
    "4.0.0" = import ./4.0.0 { inherit lib stdenv ruby; };
    "4.0.1" = import ./4.0.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "will_paginate: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "will_paginate: unknown version '${version}'")
