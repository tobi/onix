#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fastly 3.0.2
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
  pname = "fastly";
  version = "3.0.2";
  src = builtins.path {
    path = ./source;
    name = "fastly-3.0.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/fastly-3.0.2
        cp -r . $dest/gems/fastly-3.0.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/fastly-3.0.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "fastly"
      s.version = "3.0.2"
      s.summary = "fastly"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["fastly_create_domain", "fastly_upload_vcl"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/fastly_create_domain <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("fastly", "fastly_create_domain", "3.0.2")
    BINSTUB
        chmod +x $dest/bin/fastly_create_domain
        cat > $dest/bin/fastly_upload_vcl <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("fastly", "fastly_upload_vcl", "3.0.2")
    BINSTUB
        chmod +x $dest/bin/fastly_upload_vcl
  '';
}
