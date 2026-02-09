#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubyntlm 0.6.5
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
  pname = "rubyntlm";
  version = "0.6.5";
  src = builtins.path {
    path = ./source;
    name = "rubyntlm-0.6.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rubyntlm-0.6.5
        cp -r . $dest/gems/rubyntlm-0.6.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rubyntlm-0.6.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rubyntlm"
      s.version = "0.6.5"
      s.summary = "rubyntlm"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
