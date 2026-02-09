#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-partitions 1.1134.0
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "aws-partitions";
  version = "1.1134.0";
  src = builtins.path { path = ./source; name = "aws-partitions-1.1134.0-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/aws-partitions-1.1134.0
    cp -r . $dest/gems/aws-partitions-1.1134.0/
    mkdir -p $dest/specifications
    cat > $dest/specifications/aws-partitions-1.1134.0.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "aws-partitions"
  s.version = "1.1134.0"
  s.summary = "aws-partitions"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
