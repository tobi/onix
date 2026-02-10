#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sass-rails 5.0.8
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
  pname = "sass-rails";
  version = "5.0.8";
  src = builtins.path {
    path = ./source;
    name = "sass-rails-5.0.8-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/sass-rails-5.0.8
        cp -r . $dest/gems/sass-rails-5.0.8/
        mkdir -p $dest/specifications
        cat > $dest/specifications/sass-rails-5.0.8.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "sass-rails"
      s.version = "5.0.8"
      s.summary = "sass-rails"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
