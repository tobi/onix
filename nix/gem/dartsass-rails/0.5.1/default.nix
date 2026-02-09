#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# dartsass-rails 0.5.1
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
  pname = "dartsass-rails";
  version = "0.5.1";
  src = builtins.path {
    path = ./source;
    name = "dartsass-rails-0.5.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/dartsass-rails-0.5.1
        cp -r . $dest/gems/dartsass-rails-0.5.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/dartsass-rails-0.5.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "dartsass-rails"
      s.version = "0.5.1"
      s.summary = "dartsass-rails"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["dartsass"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/dartsass <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("dartsass-rails", "dartsass", "0.5.1")
    BINSTUB
        chmod +x $dest/bin/dartsass
  '';
}
