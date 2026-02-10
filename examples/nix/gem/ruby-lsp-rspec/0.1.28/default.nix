#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-lsp-rspec 0.1.28
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
  pname = "ruby-lsp-rspec";
  version = "0.1.28";
  src = builtins.path {
    path = ./source;
    name = "ruby-lsp-rspec-0.1.28-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/ruby-lsp-rspec-0.1.28
        cp -r . $dest/gems/ruby-lsp-rspec-0.1.28/
        mkdir -p $dest/specifications
        cat > $dest/specifications/ruby-lsp-rspec-0.1.28.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "ruby-lsp-rspec"
      s.version = "0.1.28"
      s.summary = "ruby-lsp-rspec"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
