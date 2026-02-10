#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rack-session 2.1.1
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
  pname = "rack-session";
  version = "2.1.1";
  src = builtins.path {
    path = ./source;
    name = "rack-session-2.1.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rack-session-2.1.1
        cp -r . $dest/gems/rack-session-2.1.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rack-session-2.1.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rack-session"
      s.version = "2.1.1"
      s.summary = "rack-session"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
