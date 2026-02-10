#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rdoc 7.1.0
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
  pname = "rdoc";
  version = "7.1.0";
  src = builtins.path {
    path = ./source;
    name = "rdoc-7.1.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rdoc-7.1.0
        cp -r . $dest/gems/rdoc-7.1.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rdoc-7.1.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rdoc"
      s.version = "7.1.0"
      s.summary = "rdoc"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["rdoc", "ri"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/rdoc <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("rdoc", "rdoc", "7.1.0")
    BINSTUB
        chmod +x $dest/bin/rdoc
        cat > $dest/bin/ri <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("rdoc", "ri", "7.1.0")
    BINSTUB
        chmod +x $dest/bin/ri
  '';
}
