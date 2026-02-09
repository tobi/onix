#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# roadie-rails 3.4.0
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
  pname = "roadie-rails";
  version = "3.4.0";
  src = builtins.path {
    path = ./source;
    name = "roadie-rails-3.4.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/roadie-rails-3.4.0
        cp -r . $dest/gems/roadie-rails-3.4.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/roadie-rails-3.4.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "roadie-rails"
      s.version = "3.4.0"
      s.summary = "roadie-rails"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
