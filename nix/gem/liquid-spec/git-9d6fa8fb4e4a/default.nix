#
# ╔═══════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/import to refresh ║
# ╚═══════════════════════════════════════════════════════╝
#
# Git: liquid-spec @ 9d6fa8fb4e4a
# URI: https://github.com/Shopify/liquid-spec.git
# Gems: liquid-spec
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
  pname = "liquid-spec";
  version = "9d6fa8fb4e4a";
  src = builtins.path {
    path = ./source;
    name = "liquid-spec-9d6fa8fb4e4a-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
    local dest=$out/${bundle_path}/bundler/gems/liquid-spec-9d6fa8fb4e4a
    mkdir -p $dest
    cp -r . $dest/
  '';
}
