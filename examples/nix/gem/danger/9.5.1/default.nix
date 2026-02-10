#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# danger 9.5.1
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
  pname = "danger";
  version = "9.5.1";
  src = builtins.path {
    path = ./source;
    name = "danger-9.5.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/danger-9.5.1
        cp -r . $dest/gems/danger-9.5.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/danger-9.5.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "danger"
      s.version = "9.5.1"
      s.summary = "danger"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["danger"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/danger <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("danger", "danger", "9.5.1")
    BINSTUB
        chmod +x $dest/bin/danger
  '';
}
