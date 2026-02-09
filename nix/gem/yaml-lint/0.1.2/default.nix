#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# yaml-lint 0.1.2
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
  pname = "yaml-lint";
  version = "0.1.2";
  src = builtins.path {
    path = ./source;
    name = "yaml-lint-0.1.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/yaml-lint-0.1.2
        cp -r . $dest/gems/yaml-lint-0.1.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/yaml-lint-0.1.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "yaml-lint"
      s.version = "0.1.2"
      s.summary = "yaml-lint"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["yaml-lint"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/yaml-lint <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("yaml-lint", "yaml-lint", "0.1.2")
    BINSTUB
        chmod +x $dest/bin/yaml-lint
  '';
}
