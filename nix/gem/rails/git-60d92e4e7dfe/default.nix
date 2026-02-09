#
# ╔══════════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate-gemset to refresh  ║
# ╚══════════════════════════════════════════════════════════════════╝
#
# Git: rails @ 60d92e4e7dfe
# URI: https://github.com/rails/rails.git
# Gems: actioncable, actionmailbox, actionmailer, actionpack, actiontext, actionview, activejob, activemodel, activerecord, activestorage, activesupport, rails, railties
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  prefix = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "rails";
  version = "60d92e4e7dfe";
  src = builtins.fetchGit {
    url = "https://github.com/rails/rails.git";
    rev = "60d92e4e7dfe923528ccdccc18820ccfe841b7b8";
    allRefs = true;
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}/bundler/gems/rails-60d92e4e7dfe
    mkdir -p $dest
    cp -r . $dest/
    rm -rf $dest/.git
  '';
}
