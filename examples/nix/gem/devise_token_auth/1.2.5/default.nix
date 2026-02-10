#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# devise_token_auth 1.2.5
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
  pname = "devise_token_auth";
  version = "1.2.5";
  src = builtins.path {
    path = ./source;
    name = "devise_token_auth-1.2.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/devise_token_auth-1.2.5
        cp -r . $dest/gems/devise_token_auth-1.2.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/devise_token_auth-1.2.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "devise_token_auth"
      s.version = "1.2.5"
      s.summary = "devise_token_auth"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
