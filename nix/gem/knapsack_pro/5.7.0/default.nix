#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# knapsack_pro 5.7.0
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
  pname = "knapsack_pro";
  version = "5.7.0";
  src = builtins.path {
    path = ./source;
    name = "knapsack_pro-5.7.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/knapsack_pro-5.7.0
        cp -r . $dest/gems/knapsack_pro-5.7.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/knapsack_pro-5.7.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "knapsack_pro"
      s.version = "5.7.0"
      s.summary = "knapsack_pro"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["knapsack_pro"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/knapsack_pro <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("knapsack_pro", "knapsack_pro", "5.7.0")
    BINSTUB
        chmod +x $dest/bin/knapsack_pro
  '';
}
