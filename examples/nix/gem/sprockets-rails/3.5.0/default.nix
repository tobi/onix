#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sprockets-rails 3.5.0
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
  version = "3.5.0";
  src = builtins.path {
    path = ./source;
    name = "sprockets-rails-3.5.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/sprockets-rails-3.5.0
        cp -r . $dest/gems/sprockets-rails-3.5.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/sprockets-rails-3.5.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "sprockets-rails"
      s.version = "3.5.0"
      s.summary = "sprockets-rails"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
