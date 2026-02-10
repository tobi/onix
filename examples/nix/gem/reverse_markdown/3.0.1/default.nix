#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# reverse_markdown 3.0.1
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
  pname = "reverse_markdown";
  version = "3.0.1";
  src = builtins.path {
    path = ./source;
    name = "reverse_markdown-3.0.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/reverse_markdown-3.0.1
        cp -r . $dest/gems/reverse_markdown-3.0.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/reverse_markdown-3.0.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "reverse_markdown"
      s.version = "3.0.1"
      s.summary = "reverse_markdown"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["reverse_markdown"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/reverse_markdown <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("reverse_markdown", "reverse_markdown", "3.0.1")
    BINSTUB
        chmod +x $dest/bin/reverse_markdown
  '';
}
