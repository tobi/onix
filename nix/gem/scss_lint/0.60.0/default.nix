#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# scss_lint 0.60.0
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
  pname = "scss_lint";
  version = "0.60.0";
  src = builtins.path {
    path = ./source;
    name = "scss_lint-0.60.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/scss_lint-0.60.0
        cp -r . $dest/gems/scss_lint-0.60.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/scss_lint-0.60.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "scss_lint"
      s.version = "0.60.0"
      s.summary = "scss_lint"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["scss-lint"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/scss-lint <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("scss_lint", "scss-lint", "0.60.0")
    BINSTUB
        chmod +x $dest/bin/scss-lint
  '';
}
