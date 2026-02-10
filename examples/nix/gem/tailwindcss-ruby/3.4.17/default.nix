#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tailwindcss-ruby 3.4.17
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
  pname = "tailwindcss-ruby";
  version = "3.4.17";
  src = builtins.path {
    path = ./source;
    name = "tailwindcss-ruby-3.4.17-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/tailwindcss-ruby-3.4.17
        cp -r . $dest/gems/tailwindcss-ruby-3.4.17/
        mkdir -p $dest/specifications
        cat > $dest/specifications/tailwindcss-ruby-3.4.17.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "tailwindcss-ruby"
      s.version = "3.4.17"
      s.summary = "tailwindcss-ruby"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["tailwindcss"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/tailwindcss <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("tailwindcss-ruby", "tailwindcss", "3.4.17")
    BINSTUB
        chmod +x $dest/bin/tailwindcss
  '';
}
