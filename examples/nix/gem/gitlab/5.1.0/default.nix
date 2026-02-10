#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# gitlab 5.1.0
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
  pname = "gitlab";
  version = "5.1.0";
  src = builtins.path {
    path = ./source;
    name = "gitlab-5.1.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/gitlab-5.1.0
        cp -r . $dest/gems/gitlab-5.1.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/gitlab-5.1.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "gitlab"
      s.version = "5.1.0"
      s.summary = "gitlab"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["gitlab"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/gitlab <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("gitlab", "gitlab", "5.1.0")
    BINSTUB
        chmod +x $dest/bin/gitlab
  '';
}
