#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-lsp 0.26.4
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "ruby-lsp";
  version = "0.26.4";
  src = builtins.path { path = ./source; name = "ruby-lsp-0.26.4-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/ruby-lsp-0.26.4
    cp -r . $dest/gems/ruby-lsp-0.26.4/
    mkdir -p $dest/specifications
    cat > $dest/specifications/ruby-lsp-0.26.4.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "ruby-lsp"
  s.version = "0.26.4"
  s.summary = "ruby-lsp"
  s.require_paths = ["lib"]
  s.bindir = "exe"
  s.executables = ["ruby-lsp", "ruby-lsp-check", "ruby-lsp-launcher", "ruby-lsp-test-exec"]
  s.files = []
end
EOF
    mkdir -p $dest/bin
    cat > $dest/bin/ruby-lsp <<'BINSTUB'
#!/usr/bin/env ruby
require "rubygems"
load Gem.bin_path("ruby-lsp", "ruby-lsp", "0.26.4")
BINSTUB
    chmod +x $dest/bin/ruby-lsp
    cat > $dest/bin/ruby-lsp-check <<'BINSTUB'
#!/usr/bin/env ruby
require "rubygems"
load Gem.bin_path("ruby-lsp", "ruby-lsp-check", "0.26.4")
BINSTUB
    chmod +x $dest/bin/ruby-lsp-check
    cat > $dest/bin/ruby-lsp-launcher <<'BINSTUB'
#!/usr/bin/env ruby
require "rubygems"
load Gem.bin_path("ruby-lsp", "ruby-lsp-launcher", "0.26.4")
BINSTUB
    chmod +x $dest/bin/ruby-lsp-launcher
    cat > $dest/bin/ruby-lsp-test-exec <<'BINSTUB'
#!/usr/bin/env ruby
require "rubygems"
load Gem.bin_path("ruby-lsp", "ruby-lsp-test-exec", "0.26.4")
BINSTUB
    chmod +x $dest/bin/ruby-lsp-test-exec
  '';
}
