#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby_llm-schema 0.2.5
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
  pname = "ruby_llm-schema";
  version = "0.2.5";
  src = builtins.path {
    path = ./source;
    name = "ruby_llm-schema-0.2.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/ruby_llm-schema-0.2.5
        cp -r . $dest/gems/ruby_llm-schema-0.2.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/ruby_llm-schema-0.2.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "ruby_llm-schema"
      s.version = "0.2.5"
      s.summary = "ruby_llm-schema"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
