#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ipaddress 0.8.3
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
  pname = "ipaddress";
  version = "0.8.3";
  src = builtins.path {
    path = ./source;
    name = "ipaddress-0.8.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/ipaddress-0.8.3
        cp -r . $dest/gems/ipaddress-0.8.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/ipaddress-0.8.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "ipaddress"
      s.version = "0.8.3"
      s.summary = "ipaddress"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
