#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby_llm 1.8.2
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
  pname = "ruby_llm";
  version = "1.8.2";
  src = builtins.path {
    path = ./source;
    name = "ruby_llm-1.8.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/ruby_llm-1.8.2
        cp -r . $dest/gems/ruby_llm-1.8.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/ruby_llm-1.8.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "ruby_llm"
      s.version = "1.8.2"
      s.summary = "ruby_llm"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
