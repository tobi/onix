#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# parallel_tests 5.4.0
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
  pname = "parallel_tests";
  version = "5.4.0";
  src = builtins.path {
    path = ./source;
    name = "parallel_tests-5.4.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/parallel_tests-5.4.0
        cp -r . $dest/gems/parallel_tests-5.4.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/parallel_tests-5.4.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "parallel_tests"
      s.version = "5.4.0"
      s.summary = "parallel_tests"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["parallel_spinach", "parallel_cucumber", "parallel_rspec", "parallel_test"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/parallel_spinach <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("parallel_tests", "parallel_spinach", "5.4.0")
    BINSTUB
        chmod +x $dest/bin/parallel_spinach
        cat > $dest/bin/parallel_cucumber <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("parallel_tests", "parallel_cucumber", "5.4.0")
    BINSTUB
        chmod +x $dest/bin/parallel_cucumber
        cat > $dest/bin/parallel_rspec <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("parallel_tests", "parallel_rspec", "5.4.0")
    BINSTUB
        chmod +x $dest/bin/parallel_rspec
        cat > $dest/bin/parallel_test <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("parallel_tests", "parallel_test", "5.4.0")
    BINSTUB
        chmod +x $dest/bin/parallel_test
  '';
}
