#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fog-aliyun 0.3.18
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
  pname = "fog-aliyun";
  version = "0.3.18";
  src = builtins.path {
    path = ./source;
    name = "fog-aliyun-0.3.18-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/fog-aliyun-0.3.18
        cp -r . $dest/gems/fog-aliyun-0.3.18/
        mkdir -p $dest/specifications
        cat > $dest/specifications/fog-aliyun-0.3.18.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "fog-aliyun"
      s.version = "0.3.18"
      s.summary = "fog-aliyun"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
