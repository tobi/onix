#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# wkhtmltopdf-binary 0.12.6.8
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
  pname = "wkhtmltopdf-binary";
  version = "0.12.6.8";
  src = builtins.path {
    path = ./source;
    name = "wkhtmltopdf-binary-0.12.6.8-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/wkhtmltopdf-binary-0.12.6.8
        cp -r . $dest/gems/wkhtmltopdf-binary-0.12.6.8/
        mkdir -p $dest/specifications
        cat > $dest/specifications/wkhtmltopdf-binary-0.12.6.8.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "wkhtmltopdf-binary"
      s.version = "0.12.6.8"
      s.summary = "wkhtmltopdf-binary"
      s.require_paths = ["."]
      s.bindir = "bin"
      s.executables = ["wkhtmltopdf"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/wkhtmltopdf <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("wkhtmltopdf-binary", "wkhtmltopdf", "0.12.6.8")
    BINSTUB
        chmod +x $dest/bin/wkhtmltopdf
  '';
}
