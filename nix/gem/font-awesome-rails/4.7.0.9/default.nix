#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# font-awesome-rails 4.7.0.9
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
  pname = "font-awesome-rails";
  version = "4.7.0.9";
  src = builtins.path {
    path = ./source;
    name = "font-awesome-rails-4.7.0.9-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/font-awesome-rails-4.7.0.9
        cp -r . $dest/gems/font-awesome-rails-4.7.0.9/
        mkdir -p $dest/specifications
        cat > $dest/specifications/font-awesome-rails-4.7.0.9.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "font-awesome-rails"
      s.version = "4.7.0.9"
      s.summary = "font-awesome-rails"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
