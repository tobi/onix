#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# stripe 18.0.1
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
  pname = "stripe";
  version = "18.0.1";
  src = builtins.path {
    path = ./source;
    name = "stripe-18.0.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/stripe-18.0.1
        cp -r . $dest/gems/stripe-18.0.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/stripe-18.0.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "stripe"
      s.version = "18.0.1"
      s.summary = "stripe"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["stripe-console"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/stripe-console <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("stripe", "stripe-console", "18.0.1")
    BINSTUB
        chmod +x $dest/bin/stripe-console
  '';
}
