#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# coffee-rails 4.2.1
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
  pname = "coffee-rails";
  version = "4.2.1";
  src = builtins.path {
    path = ./source;
    name = "coffee-rails-4.2.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/coffee-rails-4.2.1
        cp -r . $dest/gems/coffee-rails-4.2.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/coffee-rails-4.2.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "coffee-rails"
      s.version = "4.2.1"
      s.summary = "coffee-rails"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
