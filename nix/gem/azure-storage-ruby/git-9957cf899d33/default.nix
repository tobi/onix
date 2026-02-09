#
# ╔═══════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/import to refresh ║
# ╚═══════════════════════════════════════════════════════╝
#
# Git: azure-storage-ruby @ 9957cf899d33
# URI: https://github.com/chatwoot/azure-storage-ruby
# Gems: azure-storage-blob, azure-storage-common
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  prefix = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "azure-storage-ruby";
  version = "9957cf899d33";
  src = builtins.path {
    path = ./source;
    name = "azure-storage-ruby-9957cf899d33-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}/bundler/gems/azure-storage-ruby-9957cf899d33
        mkdir -p $dest
        cp -r . $dest/
        cat > $dest/azure-storage-blob.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "azure-storage-blob"
      s.version = "2.0.3"
      s.summary = "azure-storage-blob"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
        cat > $dest/azure-storage-common.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "azure-storage-common"
      s.version = "2.0.4"
      s.summary = "azure-storage-common"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
