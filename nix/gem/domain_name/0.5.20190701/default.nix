#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# domain_name 0.5.20190701
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "domain_name";
  version = "0.5.20190701";
  src = builtins.path {
    path = ./source;
    name = "domain_name-0.5.20190701-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/domain_name-0.5.20190701
        cp -r . $dest/gems/domain_name-0.5.20190701/
        mkdir -p $dest/specifications
        cat > $dest/specifications/domain_name-0.5.20190701.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "domain_name"
      s.version = "0.5.20190701"
      s.summary = "domain_name"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
