#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# safe_yaml 1.0.4
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
  pname = "safe_yaml";
  version = "1.0.4";
  src = builtins.path {
    path = ./source;
    name = "safe_yaml-1.0.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/safe_yaml-1.0.4
        cp -r . $dest/gems/safe_yaml-1.0.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/safe_yaml-1.0.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "safe_yaml"
      s.version = "1.0.4"
      s.summary = "safe_yaml"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["safe_yaml"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/safe_yaml <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("safe_yaml", "safe_yaml", "1.0.4")
    BINSTUB
        chmod +x $dest/bin/safe_yaml
  '';
}
