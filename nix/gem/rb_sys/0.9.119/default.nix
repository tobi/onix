#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rb_sys 0.9.119
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
  pname = "rb_sys";
  version = "0.9.119";
  src = builtins.path {
    path = ./source;
    name = "rb_sys-0.9.119-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rb_sys-0.9.119
        cp -r . $dest/gems/rb_sys-0.9.119/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rb_sys-0.9.119.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rb_sys"
      s.version = "0.9.119"
      s.summary = "rb_sys"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["rb-sys-dock"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/rb-sys-dock <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("rb_sys", "rb-sys-dock", "0.9.119")
    BINSTUB
        chmod +x $dest/bin/rb-sys-dock
  '';
}
