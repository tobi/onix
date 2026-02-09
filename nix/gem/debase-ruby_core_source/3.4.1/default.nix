#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# debase-ruby_core_source 3.4.1
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
  pname = "debase-ruby_core_source";
  version = "3.4.1";
  src = builtins.path {
    path = ./source;
    name = "debase-ruby_core_source-3.4.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/debase-ruby_core_source-3.4.1
        cp -r . $dest/gems/debase-ruby_core_source-3.4.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/debase-ruby_core_source-3.4.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "debase-ruby_core_source"
      s.version = "3.4.1"
      s.summary = "debase-ruby_core_source"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
