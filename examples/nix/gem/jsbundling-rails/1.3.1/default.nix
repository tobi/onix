#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# jsbundling-rails 1.3.1
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
  pname = "jsbundling-rails";
  version = "1.3.1";
  src = builtins.path {
    path = ./source;
    name = "jsbundling-rails-1.3.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/jsbundling-rails-1.3.1
        cp -r . $dest/gems/jsbundling-rails-1.3.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/jsbundling-rails-1.3.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "jsbundling-rails"
      s.version = "1.3.1"
      s.summary = "jsbundling-rails"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
