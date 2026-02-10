#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# jquery-rails 4.6.1
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
  pname = "jquery-rails";
  version = "4.6.1";
  src = builtins.path {
    path = ./source;
    name = "jquery-rails-4.6.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/jquery-rails-4.6.1
        cp -r . $dest/gems/jquery-rails-4.6.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/jquery-rails-4.6.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "jquery-rails"
      s.version = "4.6.1"
      s.summary = "jquery-rails"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
