#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# bundler-audit 0.9.1
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
  pname = "bundler-audit";
  version = "0.9.1";
  src = builtins.path {
    path = ./source;
    name = "bundler-audit-0.9.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/bundler-audit-0.9.1
        cp -r . $dest/gems/bundler-audit-0.9.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/bundler-audit-0.9.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "bundler-audit"
      s.version = "0.9.1"
      s.summary = "bundler-audit"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["bundle-audit", "bundler-audit"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/bundle-audit <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("bundler-audit", "bundle-audit", "0.9.1")
    BINSTUB
        chmod +x $dest/bin/bundle-audit
        cat > $dest/bin/bundler-audit <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("bundler-audit", "bundler-audit", "0.9.1")
    BINSTUB
        chmod +x $dest/bin/bundler-audit
  '';
}
