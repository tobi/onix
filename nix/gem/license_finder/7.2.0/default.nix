#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# license_finder 7.2.0
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
  pname = "license_finder";
  version = "7.2.0";
  src = builtins.path {
    path = ./source;
    name = "license_finder-7.2.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/license_finder-7.2.0
        cp -r . $dest/gems/license_finder-7.2.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/license_finder-7.2.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "license_finder"
      s.version = "7.2.0"
      s.summary = "license_finder"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["license_finder", "license_finder_pip.py"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/license_finder <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("license_finder", "license_finder", "7.2.0")
    BINSTUB
        chmod +x $dest/bin/license_finder
        cat > $dest/bin/license_finder_pip.py <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("license_finder", "license_finder_pip.py", "7.2.0")
    BINSTUB
        chmod +x $dest/bin/license_finder_pip.py
  '';
}
