#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fastlane 2.231.0
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
  pname = "fastlane";
  version = "2.231.0";
  src = builtins.path {
    path = ./source;
    name = "fastlane-2.231.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/fastlane-2.231.0
        cp -r . $dest/gems/fastlane-2.231.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/fastlane-2.231.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "fastlane"
      s.version = "2.231.0"
      s.summary = "fastlane"
      s.require_paths = ["cert/lib", "credentials_manager/lib", "deliver/lib", "fastlane/lib", "fastlane_core/lib", "frameit/lib", "gym/lib", "match/lib", "pem/lib", "pilot/lib", "precheck/lib", "produce/lib", "scan/lib", "screengrab/lib", "sigh/lib", "snapshot/lib", "spaceship/lib", "supply/lib", "trainer/lib"]
      s.bindir = "bin"
      s.executables = ["bin-proxy", "console", "fastlane", "match_file"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/bin-proxy <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("fastlane", "bin-proxy", "2.231.0")
    BINSTUB
        chmod +x $dest/bin/bin-proxy
        cat > $dest/bin/console <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("fastlane", "console", "2.231.0")
    BINSTUB
        chmod +x $dest/bin/console
        cat > $dest/bin/fastlane <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("fastlane", "fastlane", "2.231.0")
    BINSTUB
        chmod +x $dest/bin/fastlane
        cat > $dest/bin/match_file <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("fastlane", "match_file", "2.231.0")
    BINSTUB
        chmod +x $dest/bin/match_file
  '';
}
