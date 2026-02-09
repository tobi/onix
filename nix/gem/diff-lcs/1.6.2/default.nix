#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# diff-lcs 1.6.2
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "diff-lcs";
  version = "1.6.2";
  src = builtins.path {
    path = ./source;
    name = "diff-lcs-1.6.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/diff-lcs-1.6.2
        cp -r . $dest/gems/diff-lcs-1.6.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/diff-lcs-1.6.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "diff-lcs"
      s.version = "1.6.2"
      s.summary = "diff-lcs"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["htmldiff", "ldiff"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/htmldiff <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("diff-lcs", "htmldiff", "1.6.2")
    BINSTUB
        chmod +x $dest/bin/htmldiff
        cat > $dest/bin/ldiff <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("diff-lcs", "ldiff", "1.6.2")
    BINSTUB
        chmod +x $dest/bin/ldiff
  '';
}
