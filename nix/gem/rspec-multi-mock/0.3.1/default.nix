#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rspec-multi-mock 0.3.1
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "rspec-multi-mock";
  version = "0.3.1";
  src = builtins.path {
    path = ./source;
    name = "rspec-multi-mock-0.3.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/rspec-multi-mock-0.3.1
        cp -r . $dest/gems/rspec-multi-mock-0.3.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rspec-multi-mock-0.3.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rspec-multi-mock"
      s.version = "0.3.1"
      s.summary = "rspec-multi-mock"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
