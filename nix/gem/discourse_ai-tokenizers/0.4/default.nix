#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# discourse_ai-tokenizers 0.4
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
  pname = "discourse_ai-tokenizers";
  version = "0.4";
  src = builtins.path {
    path = ./source;
    name = "discourse_ai-tokenizers-0.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/discourse_ai-tokenizers-0.4
        cp -r . $dest/gems/discourse_ai-tokenizers-0.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/discourse_ai-tokenizers-0.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "discourse_ai-tokenizers"
      s.version = "0.4"
      s.summary = "discourse_ai-tokenizers"
      s.require_paths = ["lib", "vendor"]
      s.files = []
    end
    EOF
  '';
}
