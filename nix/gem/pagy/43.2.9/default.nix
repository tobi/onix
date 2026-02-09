#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pagy 43.2.9
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
  pname = "pagy";
  version = "43.2.9";
  src = builtins.path {
    path = ./source;
    name = "pagy-43.2.9-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/pagy-43.2.9
        cp -r . $dest/gems/pagy-43.2.9/
        mkdir -p $dest/specifications
        cat > $dest/specifications/pagy-43.2.9.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "pagy"
      s.version = "43.2.9"
      s.summary = "pagy"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["pagy"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/pagy <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("pagy", "pagy", "43.2.9")
    BINSTUB
        chmod +x $dest/bin/pagy
  '';
}
