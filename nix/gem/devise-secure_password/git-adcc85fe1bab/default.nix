#
# ╔═══════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/import to refresh ║
# ╚═══════════════════════════════════════════════════════╝
#
# Git: devise-secure_password @ adcc85fe1bab
# URI: https://github.com/chatwoot/devise-secure_password
# Gems: devise-secure_password
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
  pname = "devise-secure_password";
  version = "adcc85fe1bab";
  src = builtins.path {
    path = ./source;
    name = "devise-secure_password-adcc85fe1bab-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
    local dest=$out/${bundle_path}/bundler/gems/devise-secure_password-adcc85fe1bab
    mkdir -p $dest
    cp -r . $dest/
  '';
}
