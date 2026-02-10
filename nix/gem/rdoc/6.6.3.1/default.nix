#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rdoc 6.6.3.1
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
  version = "6.6.3.1";
  src = builtins.path {
    path = ./source;
    name = "rdoc-6.6.3.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rdoc-6.6.3.1
        cp -r . $dest/gems/rdoc-6.6.3.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rdoc-6.6.3.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rdoc"
      s.version = "6.6.3.1"
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
    load Gem.bin_path("rdoc", "rdoc", "6.6.3.1")
    BINSTUB
        chmod +x $dest/bin/rdoc
        cat > $dest/bin/ri <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("rdoc", "ri", "6.6.3.1")
    BINSTUB
        chmod +x $dest/bin/ri
  '';
}
