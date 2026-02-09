#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# useragent 0.16.11
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
  pname = "useragent";
  version = "0.16.11";
  src = builtins.path {
    path = ./source;
    name = "useragent-0.16.11-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/useragent-0.16.11
        cp -r . $dest/gems/useragent-0.16.11/
        mkdir -p $dest/specifications
        cat > $dest/specifications/useragent-0.16.11.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "useragent"
      s.version = "0.16.11"
      s.summary = "useragent"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
