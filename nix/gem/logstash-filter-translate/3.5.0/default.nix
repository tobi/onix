#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# logstash-filter-translate 3.5.0
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
  pname = "logstash-filter-translate";
  version = "3.5.0";
  src = builtins.path {
    path = ./source;
    name = "logstash-filter-translate-3.5.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/logstash-filter-translate-3.5.0
        cp -r . $dest/gems/logstash-filter-translate-3.5.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/logstash-filter-translate-3.5.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "logstash-filter-translate"
      s.version = "3.5.0"
      s.summary = "logstash-filter-translate"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
