#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# haml_lint 0.69.0
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
  pname = "haml_lint";
  version = "0.69.0";
  src = builtins.path {
    path = ./source;
    name = "haml_lint-0.69.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/haml_lint-0.69.0
        cp -r . $dest/gems/haml_lint-0.69.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/haml_lint-0.69.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "haml_lint"
      s.version = "0.69.0"
      s.summary = "haml_lint"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["haml-lint"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/haml-lint <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("haml_lint", "haml-lint", "0.69.0")
    BINSTUB
        chmod +x $dest/bin/haml-lint
  '';
}
