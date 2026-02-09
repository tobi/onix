#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sprockets-rails 3.4.2
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
  pname = "sprockets-rails";
  version = "3.4.2";
  src = builtins.path {
    path = ./source;
    name = "sprockets-rails-3.4.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/sprockets-rails-3.4.2
        cp -r . $dest/gems/sprockets-rails-3.4.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/sprockets-rails-3.4.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "sprockets-rails"
      s.version = "3.4.2"
      s.summary = "sprockets-rails"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
