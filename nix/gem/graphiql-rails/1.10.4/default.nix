#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# graphiql-rails 1.10.4
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
  pname = "graphiql-rails";
  version = "1.10.4";
  src = builtins.path {
    path = ./source;
    name = "graphiql-rails-1.10.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/graphiql-rails-1.10.4
        cp -r . $dest/gems/graphiql-rails-1.10.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/graphiql-rails-1.10.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "graphiql-rails"
      s.version = "1.10.4"
      s.summary = "graphiql-rails"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
