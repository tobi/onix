#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ssrf_filter 1.1.2
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
  pname = "ssrf_filter";
  version = "1.1.2";
  src = builtins.path {
    path = ./source;
    name = "ssrf_filter-1.1.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/ssrf_filter-1.1.2
        cp -r . $dest/gems/ssrf_filter-1.1.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/ssrf_filter-1.1.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "ssrf_filter"
      s.version = "1.1.2"
      s.summary = "ssrf_filter"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
