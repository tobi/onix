#
# ╔═══════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/import to refresh ║
# ╚═══════════════════════════════════════════════════════╝
#
# Git: lexxy @ 4f0fc4d5773b
# URI: https://github.com/basecamp/lexxy
# Gems: lexxy
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  bundle_path = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "lexxy";
  version = "4f0fc4d5773b";
  src = builtins.path {
    path = ./source;
    name = "lexxy-4f0fc4d5773b-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
    local dest=$out/${bundle_path}/bundler/gems/lexxy-4f0fc4d5773b
    mkdir -p $dest
    cp -r . $dest/
  '';
}
