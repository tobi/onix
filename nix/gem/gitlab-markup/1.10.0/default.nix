#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# gitlab-markup 1.10.0
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
  pname = "gitlab-markup";
  version = "1.10.0";
  src = builtins.path {
    path = ./source;
    name = "gitlab-markup-1.10.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/gitlab-markup-1.10.0
        cp -r . $dest/gems/gitlab-markup-1.10.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/gitlab-markup-1.10.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "gitlab-markup"
      s.version = "1.10.0"
      s.summary = "gitlab-markup"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["gitlab-markup"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/gitlab-markup <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("gitlab-markup", "gitlab-markup", "1.10.0")
    BINSTUB
        chmod +x $dest/bin/gitlab-markup
  '';
}
