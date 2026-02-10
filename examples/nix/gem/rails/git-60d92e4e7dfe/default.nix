#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
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
  bundle_path = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "rails";
  version = "60d92e4e7dfe";
  src = builtins.path {
    path = ./source;
    name = "rails-60d92e4e7dfe-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}/bundler/gems/rails-60d92e4e7dfe
        mkdir -p $dest
        cp -r . $dest/
  '';
}
