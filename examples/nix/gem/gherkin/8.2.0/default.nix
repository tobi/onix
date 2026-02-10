#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# gherkin 8.2.0
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
  pname = "gherkin";
  version = "8.2.0";
  src = builtins.path {
    path = ./source;
    name = "gherkin-8.2.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/gherkin-8.2.0
        cp -r . $dest/gems/gherkin-8.2.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/gherkin-8.2.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "gherkin"
      s.version = "8.2.0"
      s.summary = "gherkin"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["gherkin-ruby", "gherkin"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/gherkin-ruby <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("gherkin", "gherkin-ruby", "8.2.0")
    BINSTUB
        chmod +x $dest/bin/gherkin-ruby
        cat > $dest/bin/gherkin <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("gherkin", "gherkin", "8.2.0")
    BINSTUB
        chmod +x $dest/bin/gherkin
  '';
}
