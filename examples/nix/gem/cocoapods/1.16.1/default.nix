#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cocoapods 1.16.1
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
  pname = "cocoapods";
  version = "1.16.1";
  src = builtins.path {
    path = ./source;
    name = "cocoapods-1.16.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/cocoapods-1.16.1
        cp -r . $dest/gems/cocoapods-1.16.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/cocoapods-1.16.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "cocoapods"
      s.version = "1.16.1"
      s.summary = "cocoapods"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["pod", "sandbox-pod"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/pod <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("cocoapods", "pod", "1.16.1")
    BINSTUB
        chmod +x $dest/bin/pod
        cat > $dest/bin/sandbox-pod <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("cocoapods", "sandbox-pod", "1.16.1")
    BINSTUB
        chmod +x $dest/bin/sandbox-pod
  '';
}
