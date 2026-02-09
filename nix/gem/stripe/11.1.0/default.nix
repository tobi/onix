#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# stripe 11.1.0
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
  version = "11.1.0";
  src = builtins.path {
    path = ./source;
    name = "stripe-11.1.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/stripe-11.1.0
        cp -r . $dest/gems/stripe-11.1.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/stripe-11.1.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "stripe"
      s.version = "11.1.0"
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
    load Gem.bin_path("stripe", "stripe-console", "11.1.0")
    BINSTUB
        chmod +x $dest/bin/stripe-console
  '';
}
