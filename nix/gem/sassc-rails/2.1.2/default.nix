#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sassc-rails 2.1.2
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
  pname = "sassc-rails";
  version = "2.1.2";
  src = builtins.path {
    path = ./source;
    name = "sassc-rails-2.1.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/sassc-rails-2.1.2
        cp -r . $dest/gems/sassc-rails-2.1.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/sassc-rails-2.1.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "sassc-rails"
      s.version = "2.1.2"
      s.summary = "sassc-rails"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
