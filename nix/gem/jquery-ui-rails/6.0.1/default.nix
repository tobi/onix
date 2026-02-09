#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# jquery-ui-rails 6.0.1
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
  pname = "jquery-ui-rails";
  version = "6.0.1";
  src = builtins.path {
    path = ./source;
    name = "jquery-ui-rails-6.0.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/jquery-ui-rails-6.0.1
        cp -r . $dest/gems/jquery-ui-rails-6.0.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/jquery-ui-rails-6.0.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "jquery-ui-rails"
      s.version = "6.0.1"
      s.summary = "jquery-ui-rails"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
