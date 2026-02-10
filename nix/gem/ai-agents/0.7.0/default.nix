#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ai-agents 0.7.0
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
  pname = "ai-agents";
  version = "0.7.0";
  src = builtins.path {
    path = ./source;
    name = "ai-agents-0.7.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/ai-agents-0.7.0
        cp -r . $dest/gems/ai-agents-0.7.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/ai-agents-0.7.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "ai-agents"
      s.version = "0.7.0"
      s.summary = "ai-agents"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
