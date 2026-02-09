#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop-rspec 2.29.1
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
  pname = "rubocop-rspec";
  version = "2.29.1";
  src = builtins.path {
    path = ./source;
    name = "rubocop-rspec-2.29.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rubocop-rspec-2.29.1
        cp -r . $dest/gems/rubocop-rspec-2.29.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rubocop-rspec-2.29.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rubocop-rspec"
      s.version = "2.29.1"
      s.summary = "rubocop-rspec"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
