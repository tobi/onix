#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# simplecov_json_formatter 0.1.3
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
  pname = "simplecov_json_formatter";
  version = "0.1.3";
  src = builtins.path {
    path = ./source;
    name = "simplecov_json_formatter-0.1.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/simplecov_json_formatter-0.1.3
        cp -r . $dest/gems/simplecov_json_formatter-0.1.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/simplecov_json_formatter-0.1.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "simplecov_json_formatter"
      s.version = "0.1.3"
      s.summary = "simplecov_json_formatter"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
