#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# spring-commands-rspec 1.0.3
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
  pname = "spring-commands-rspec";
  version = "1.0.3";
  src = builtins.path {
    path = ./source;
    name = "spring-commands-rspec-1.0.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/spring-commands-rspec-1.0.3
        cp -r . $dest/gems/spring-commands-rspec-1.0.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/spring-commands-rspec-1.0.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "spring-commands-rspec"
      s.version = "1.0.3"
      s.summary = "spring-commands-rspec"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
