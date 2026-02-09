#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# devise_invitable 2.0.9
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
  pname = "devise_invitable";
  version = "2.0.9";
  src = builtins.path {
    path = ./source;
    name = "devise_invitable-2.0.9-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/devise_invitable-2.0.9
        cp -r . $dest/gems/devise_invitable-2.0.9/
        mkdir -p $dest/specifications
        cat > $dest/specifications/devise_invitable-2.0.9.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "devise_invitable"
      s.version = "2.0.9"
      s.summary = "devise_invitable"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
