#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pry-rails 0.3.9
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
  pname = "pry-rails";
  version = "0.3.9";
  src = builtins.path {
    path = ./source;
    name = "pry-rails-0.3.9-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/pry-rails-0.3.9
        cp -r . $dest/gems/pry-rails-0.3.9/
        mkdir -p $dest/specifications
        cat > $dest/specifications/pry-rails-0.3.9.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "pry-rails"
      s.version = "0.3.9"
      s.summary = "pry-rails"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
