#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cypress-rails 0.7.0
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  bundle_path = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "cypress-rails";
  version = "0.7.0";
  src = builtins.path {
    path = ./source;
    name = "cypress-rails-0.7.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/cypress-rails-0.7.0
        cp -r . $dest/gems/cypress-rails-0.7.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/cypress-rails-0.7.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "cypress-rails"
      s.version = "0.7.0"
      s.summary = "cypress-rails"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["cypress-rails"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/cypress-rails <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("cypress-rails", "cypress-rails", "0.7.0")
    BINSTUB
        chmod +x $dest/bin/cypress-rails
  '';
}
