#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# azure-blob 0.5.9.1
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
  pname = "azure-blob";
  version = "0.5.9.1";
  src = builtins.path {
    path = ./source;
    name = "azure-blob-0.5.9.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/azure-blob-0.5.9.1
        cp -r . $dest/gems/azure-blob-0.5.9.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/azure-blob-0.5.9.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "azure-blob"
      s.version = "0.5.9.1"
      s.summary = "azure-blob"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
