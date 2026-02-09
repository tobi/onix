#
# ╔═══════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/import to refresh ║
# ╚═══════════════════════════════════════════════════════╝
#
# Git: acts_as_follower @ 06393d3693a1
# URI: https://github.com/forem/acts_as_follower.git
# Gems: acts_as_follower
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
  pname = "acts_as_follower";
  version = "06393d3693a1";
  src = builtins.path {
    path = ./source;
    name = "acts_as_follower-06393d3693a1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
    local dest=$out/${bundle_path}/bundler/gems/acts_as_follower-06393d3693a1
    mkdir -p $dest
    cp -r . $dest/
  '';
}
