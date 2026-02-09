#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# active_record_union 1.3.0
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
  pname = "active_record_union";
  version = "1.3.0";
  src = builtins.path {
    path = ./source;
    name = "active_record_union-1.3.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/active_record_union-1.3.0
        cp -r . $dest/gems/active_record_union-1.3.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/active_record_union-1.3.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "active_record_union"
      s.version = "1.3.0"
      s.summary = "active_record_union"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
