#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# stripe-ruby-mock 3.1.0.rc3
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
  pname = "stripe-ruby-mock";
  version = "3.1.0.rc3";
  src = builtins.path {
    path = ./source;
    name = "stripe-ruby-mock-3.1.0.rc3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/stripe-ruby-mock-3.1.0.rc3
        cp -r . $dest/gems/stripe-ruby-mock-3.1.0.rc3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/stripe-ruby-mock-3.1.0.rc3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "stripe-ruby-mock"
      s.version = "3.1.0.rc3"
      s.summary = "stripe-ruby-mock"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["stripe-mock-server"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/stripe-mock-server <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("stripe-ruby-mock", "stripe-mock-server", "3.1.0.rc3")
    BINSTUB
        chmod +x $dest/bin/stripe-mock-server
  '';
}
