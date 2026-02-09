#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# emoji_regex 3.2.3
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
  pname = "emoji_regex";
  version = "3.2.3";
  src = builtins.path {
    path = ./source;
    name = "emoji_regex-3.2.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/emoji_regex-3.2.3
        cp -r . $dest/gems/emoji_regex-3.2.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/emoji_regex-3.2.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "emoji_regex"
      s.version = "3.2.3"
      s.summary = "emoji_regex"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
