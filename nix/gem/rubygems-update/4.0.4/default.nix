#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubygems-update 4.0.4
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
  pname = "rubygems-update";
  version = "4.0.4";
  src = builtins.path {
    path = ./source;
    name = "rubygems-update-4.0.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rubygems-update-4.0.4
        cp -r . $dest/gems/rubygems-update-4.0.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rubygems-update-4.0.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rubygems-update"
      s.version = "4.0.4"
      s.summary = "rubygems-update"
      s.require_paths = ["hide_lib_for_update"]
      s.bindir = "exe"
      s.executables = ["update_rubygems"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/update_rubygems <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("rubygems-update", "update_rubygems", "4.0.4")
    BINSTUB
        chmod +x $dest/bin/update_rubygems
  '';
}
