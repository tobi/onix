#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# gitlab-labkit 1.3.2
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
  pname = "gitlab-labkit";
  version = "1.3.2";
  src = builtins.path {
    path = ./source;
    name = "gitlab-labkit-1.3.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/gitlab-labkit-1.3.2
        cp -r . $dest/gems/gitlab-labkit-1.3.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/gitlab-labkit-1.3.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "gitlab-labkit"
      s.version = "1.3.2"
      s.summary = "gitlab-labkit"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["labkit-logging"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/labkit-logging <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("gitlab-labkit", "labkit-logging", "1.3.2")
    BINSTUB
        chmod +x $dest/bin/labkit-logging
  '';
}
