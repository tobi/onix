#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# patience_diff 1.2.0
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
  pname = "patience_diff";
  version = "1.2.0";
  src = builtins.path {
    path = ./source;
    name = "patience_diff-1.2.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/patience_diff-1.2.0
        cp -r . $dest/gems/patience_diff-1.2.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/patience_diff-1.2.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "patience_diff"
      s.version = "1.2.0"
      s.summary = "patience_diff"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["patience_diff"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/patience_diff <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("patience_diff", "patience_diff", "1.2.0")
    BINSTUB
        chmod +x $dest/bin/patience_diff
  '';
}
