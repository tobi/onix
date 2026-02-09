#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# gettext 3.5.1
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
  pname = "gettext";
  version = "3.5.1";
  src = builtins.path {
    path = ./source;
    name = "gettext-3.5.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/gettext-3.5.1
        cp -r . $dest/gems/gettext-3.5.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/gettext-3.5.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "gettext"
      s.version = "3.5.1"
      s.summary = "gettext"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["rmsgcat", "rmsgfmt", "rmsginit", "rmsgmerge", "rxgettext"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/rmsgcat <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("gettext", "rmsgcat", "3.5.1")
    BINSTUB
        chmod +x $dest/bin/rmsgcat
        cat > $dest/bin/rmsgfmt <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("gettext", "rmsgfmt", "3.5.1")
    BINSTUB
        chmod +x $dest/bin/rmsgfmt
        cat > $dest/bin/rmsginit <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("gettext", "rmsginit", "3.5.1")
    BINSTUB
        chmod +x $dest/bin/rmsginit
        cat > $dest/bin/rmsgmerge <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("gettext", "rmsgmerge", "3.5.1")
    BINSTUB
        chmod +x $dest/bin/rmsgmerge
        cat > $dest/bin/rxgettext <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("gettext", "rxgettext", "3.5.1")
    BINSTUB
        chmod +x $dest/bin/rxgettext
  '';
}
