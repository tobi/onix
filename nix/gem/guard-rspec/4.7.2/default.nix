#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# guard-rspec 4.7.2
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
  pname = "guard-rspec";
  version = "4.7.2";
  src = builtins.path {
    path = ./source;
    name = "guard-rspec-4.7.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/guard-rspec-4.7.2
        cp -r . $dest/gems/guard-rspec-4.7.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/guard-rspec-4.7.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "guard-rspec"
      s.version = "4.7.2"
      s.summary = "guard-rspec"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
