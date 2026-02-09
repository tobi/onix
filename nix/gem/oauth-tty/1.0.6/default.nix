#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# oauth-tty 1.0.6
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
  pname = "oauth-tty";
  version = "1.0.6";
  src = builtins.path {
    path = ./source;
    name = "oauth-tty-1.0.6-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/oauth-tty-1.0.6
        cp -r . $dest/gems/oauth-tty-1.0.6/
        mkdir -p $dest/specifications
        cat > $dest/specifications/oauth-tty-1.0.6.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "oauth-tty"
      s.version = "1.0.6"
      s.summary = "oauth-tty"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["oauth"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/oauth <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("oauth-tty", "oauth", "1.0.6")
    BINSTUB
        chmod +x $dest/bin/oauth
  '';
}
