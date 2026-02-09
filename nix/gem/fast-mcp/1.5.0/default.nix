#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fast-mcp 1.5.0
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
  pname = "fast-mcp";
  version = "1.5.0";
  src = builtins.path {
    path = ./source;
    name = "fast-mcp-1.5.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/fast-mcp-1.5.0
        cp -r . $dest/gems/fast-mcp-1.5.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/fast-mcp-1.5.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "fast-mcp"
      s.version = "1.5.0"
      s.summary = "fast-mcp"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
