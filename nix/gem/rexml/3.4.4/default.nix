#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rexml 3.4.4
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
  pname = "rexml";
  version = "3.4.4";
  src = builtins.path {
    path = ./source;
    name = "rexml-3.4.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rexml-3.4.4
        cp -r . $dest/gems/rexml-3.4.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rexml-3.4.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rexml"
      s.version = "3.4.4"
      s.summary = "rexml"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
