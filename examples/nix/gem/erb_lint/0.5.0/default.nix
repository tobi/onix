#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# erb_lint 0.5.0
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
  pname = "erb_lint";
  version = "0.5.0";
  src = builtins.path {
    path = ./source;
    name = "erb_lint-0.5.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/erb_lint-0.5.0
        cp -r . $dest/gems/erb_lint-0.5.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/erb_lint-0.5.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "erb_lint"
      s.version = "0.5.0"
      s.summary = "erb_lint"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["erblint"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/erblint <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("erb_lint", "erblint", "0.5.0")
    BINSTUB
        chmod +x $dest/bin/erblint
  '';
}
