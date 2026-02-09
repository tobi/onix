#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop-rails 2.34.3
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
  pname = "rubocop-rails";
  version = "2.34.3";
  src = builtins.path {
    path = ./source;
    name = "rubocop-rails-2.34.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rubocop-rails-2.34.3
        cp -r . $dest/gems/rubocop-rails-2.34.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rubocop-rails-2.34.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rubocop-rails"
      s.version = "2.34.3"
      s.summary = "rubocop-rails"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
