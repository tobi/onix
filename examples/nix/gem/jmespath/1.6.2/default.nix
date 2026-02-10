#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# jmespath 1.6.2
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
  pname = "jmespath";
  version = "1.6.2";
  src = builtins.path {
    path = ./source;
    name = "jmespath-1.6.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/jmespath-1.6.2
        cp -r . $dest/gems/jmespath-1.6.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/jmespath-1.6.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "jmespath"
      s.version = "1.6.2"
      s.summary = "jmespath"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["jmespath.rb"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/jmespath.rb <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("jmespath", "jmespath.rb", "1.6.2")
    BINSTUB
        chmod +x $dest/bin/jmespath.rb
  '';
}
