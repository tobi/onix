#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# reline 0.6.2
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
  pname = "reline";
  version = "0.6.2";
  src = builtins.path {
    path = ./source;
    name = "reline-0.6.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/reline-0.6.2
        cp -r . $dest/gems/reline-0.6.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/reline-0.6.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "reline"
      s.version = "0.6.2"
      s.summary = "reline"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
