#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# bundler 4.0.4
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
  pname = "bundler";
  version = "4.0.4";
  src = builtins.path {
    path = ./source;
    name = "bundler-4.0.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/bundler-4.0.4
        cp -r . $dest/gems/bundler-4.0.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/bundler-4.0.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "bundler"
      s.version = "4.0.4"
      s.summary = "bundler"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["bundle", "bundler"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/bundle <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("bundler", "bundle", "4.0.4")
    BINSTUB
        chmod +x $dest/bin/bundle
        cat > $dest/bin/bundler <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("bundler", "bundler", "4.0.4")
    BINSTUB
        chmod +x $dest/bin/bundler
  '';
}
