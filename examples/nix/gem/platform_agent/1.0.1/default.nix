#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# platform_agent 1.0.1
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
  pname = "platform_agent";
  version = "1.0.1";
  src = builtins.path {
    path = ./source;
    name = "platform_agent-1.0.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/platform_agent-1.0.1
        cp -r . $dest/gems/platform_agent-1.0.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/platform_agent-1.0.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "platform_agent"
      s.version = "1.0.1"
      s.summary = "platform_agent"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
