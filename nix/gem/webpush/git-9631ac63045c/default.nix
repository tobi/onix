#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix import to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# Git: webpush @ 9631ac63045c
# URI: https://github.com/mastodon/webpush.git
# Gems: webpush
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
  pname = "webpush";
  version = "9631ac63045c";
  src = builtins.path {
    path = ./source;
    name = "webpush-9631ac63045c-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}/bundler/gems/webpush-9631ac63045c
        mkdir -p $dest
        cp -r . $dest/
  '';
}
