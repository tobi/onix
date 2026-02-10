#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# coffee-rails 4.2.2
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
  version = "4.2.2";
  src = builtins.path {
    path = ./source;
    name = "coffee-rails-4.2.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/coffee-rails-4.2.2
        cp -r . $dest/gems/coffee-rails-4.2.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/coffee-rails-4.2.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "coffee-rails"
      s.version = "4.2.2"
      s.summary = "coffee-rails"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
