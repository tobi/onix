#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# solargraph 0.50.0
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
  pname = "solargraph";
  version = "0.50.0";
  src = builtins.path {
    path = ./source;
    name = "solargraph-0.50.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/solargraph-0.50.0
        cp -r . $dest/gems/solargraph-0.50.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/solargraph-0.50.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "solargraph"
      s.version = "0.50.0"
      s.summary = "solargraph"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["solargraph"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/solargraph <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("solargraph", "solargraph", "0.50.0")
    BINSTUB
        chmod +x $dest/bin/solargraph
  '';
}
