#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# atlassian-jwt 0.2.0
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
  pname = "atlassian-jwt";
  version = "0.2.0";
  src = builtins.path {
    path = ./source;
    name = "atlassian-jwt-0.2.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/atlassian-jwt-0.2.0
        cp -r . $dest/gems/atlassian-jwt-0.2.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/atlassian-jwt-0.2.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "atlassian-jwt"
      s.version = "0.2.0"
      s.summary = "atlassian-jwt"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
