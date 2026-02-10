#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop-performance 1.21.0
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
  pname = "rubocop-performance";
  version = "1.21.0";
  src = builtins.path {
    path = ./source;
    name = "rubocop-performance-1.21.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rubocop-performance-1.21.0
        cp -r . $dest/gems/rubocop-performance-1.21.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rubocop-performance-1.21.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rubocop-performance"
      s.version = "1.21.0"
      s.summary = "rubocop-performance"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
