#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# diff-lcs 2.0.0.beta.2
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
  pname = "diff-lcs";
  version = "2.0.0.beta.2";
  src = builtins.path {
    path = ./source;
    name = "diff-lcs-2.0.0.beta.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/diff-lcs-2.0.0.beta.2
        cp -r . $dest/gems/diff-lcs-2.0.0.beta.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/diff-lcs-2.0.0.beta.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "diff-lcs"
      s.version = "2.0.0.beta.2"
      s.summary = "diff-lcs"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["ldiff"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/ldiff <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("diff-lcs", "ldiff", "2.0.0.beta.2")
    BINSTUB
        chmod +x $dest/bin/ldiff
  '';
}
