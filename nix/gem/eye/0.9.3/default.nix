#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# eye 0.9.3
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
  pname = "eye";
  version = "0.9.3";
  src = builtins.path {
    path = ./source;
    name = "eye-0.9.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/eye-0.9.3
        cp -r . $dest/gems/eye-0.9.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/eye-0.9.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "eye"
      s.version = "0.9.3"
      s.summary = "eye"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["eye", "leye", "loader_eye"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/eye <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("eye", "eye", "0.9.3")
    BINSTUB
        chmod +x $dest/bin/eye
        cat > $dest/bin/leye <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("eye", "leye", "0.9.3")
    BINSTUB
        chmod +x $dest/bin/leye
        cat > $dest/bin/loader_eye <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("eye", "loader_eye", "0.9.3")
    BINSTUB
        chmod +x $dest/bin/loader_eye
  '';
}
