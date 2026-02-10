#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# oauth 0.5.10
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
  pname = "oauth";
  version = "0.5.10";
  src = builtins.path {
    path = ./source;
    name = "oauth-0.5.10-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/oauth-0.5.10
        cp -r . $dest/gems/oauth-0.5.10/
        mkdir -p $dest/specifications
        cat > $dest/specifications/oauth-0.5.10.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "oauth"
      s.version = "0.5.10"
      s.summary = "oauth"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["oauth"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/oauth <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("oauth", "oauth", "0.5.10")
    BINSTUB
        chmod +x $dest/bin/oauth
  '';
}
