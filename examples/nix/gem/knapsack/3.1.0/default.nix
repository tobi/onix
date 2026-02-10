#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# knapsack 3.1.0
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
  pname = "knapsack";
  version = "3.1.0";
  src = builtins.path {
    path = ./source;
    name = "knapsack-3.1.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/knapsack-3.1.0
        cp -r . $dest/gems/knapsack-3.1.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/knapsack-3.1.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "knapsack"
      s.version = "3.1.0"
      s.summary = "knapsack"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["knapsack"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/knapsack <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("knapsack", "knapsack", "3.1.0")
    BINSTUB
        chmod +x $dest/bin/knapsack
  '';
}
