#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# turbo-rails 2.0.23
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
  pname = "turbo-rails";
  version = "2.0.23";
  src = builtins.path {
    path = ./source;
    name = "turbo-rails-2.0.23-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/turbo-rails-2.0.23
        cp -r . $dest/gems/turbo-rails-2.0.23/
        mkdir -p $dest/specifications
        cat > $dest/specifications/turbo-rails-2.0.23.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "turbo-rails"
      s.version = "2.0.23"
      s.summary = "turbo-rails"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
