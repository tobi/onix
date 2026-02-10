#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# jsonapi-rspec 0.0.11
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
  pname = "jsonapi-rspec";
  version = "0.0.11";
  src = builtins.path {
    path = ./source;
    name = "jsonapi-rspec-0.0.11-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/jsonapi-rspec-0.0.11
        cp -r . $dest/gems/jsonapi-rspec-0.0.11/
        mkdir -p $dest/specifications
        cat > $dest/specifications/jsonapi-rspec-0.0.11.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "jsonapi-rspec"
      s.version = "0.0.11"
      s.summary = "jsonapi-rspec"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
