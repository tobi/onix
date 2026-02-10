#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-saml 1.18.1
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
  pname = "ruby-saml";
  version = "1.18.1";
  src = builtins.path {
    path = ./source;
    name = "ruby-saml-1.18.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/ruby-saml-1.18.1
        cp -r . $dest/gems/ruby-saml-1.18.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/ruby-saml-1.18.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "ruby-saml"
      s.version = "1.18.1"
      s.summary = "ruby-saml"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
