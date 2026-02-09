#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# chronic 0.10.2
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
  pname = "chronic";
  version = "0.10.2";
  src = builtins.path {
    path = ./source;
    name = "chronic-0.10.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/chronic-0.10.2
        cp -r . $dest/gems/chronic-0.10.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/chronic-0.10.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "chronic"
      s.version = "0.10.2"
      s.summary = "chronic"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
