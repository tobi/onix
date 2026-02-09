#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# get_process_mem 0.2.7
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
  pname = "get_process_mem";
  version = "0.2.7";
  src = builtins.path {
    path = ./source;
    name = "get_process_mem-0.2.7-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/get_process_mem-0.2.7
        cp -r . $dest/gems/get_process_mem-0.2.7/
        mkdir -p $dest/specifications
        cat > $dest/specifications/get_process_mem-0.2.7.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "get_process_mem"
      s.version = "0.2.7"
      s.summary = "get_process_mem"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
