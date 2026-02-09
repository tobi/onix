#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# no_proxy_fix 0.1.1
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
  pname = "no_proxy_fix";
  version = "0.1.1";
  src = builtins.path {
    path = ./source;
    name = "no_proxy_fix-0.1.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/no_proxy_fix-0.1.1
        cp -r . $dest/gems/no_proxy_fix-0.1.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/no_proxy_fix-0.1.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "no_proxy_fix"
      s.version = "0.1.1"
      s.summary = "no_proxy_fix"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
