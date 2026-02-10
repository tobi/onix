#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ipaddress 0.8.2
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
  version = "0.8.2";
  src = builtins.path {
    path = ./source;
    name = "ipaddress-0.8.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/ipaddress-0.8.2
        cp -r . $dest/gems/ipaddress-0.8.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/ipaddress-0.8.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "ipaddress"
      s.version = "0.8.2"
      s.summary = "ipaddress"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
