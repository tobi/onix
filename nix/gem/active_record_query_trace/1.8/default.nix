#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# active_record_query_trace 1.8
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
  pname = "active_record_query_trace";
  version = "1.8";
  src = builtins.path {
    path = ./source;
    name = "active_record_query_trace-1.8-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/active_record_query_trace-1.8
        cp -r . $dest/gems/active_record_query_trace-1.8/
        mkdir -p $dest/specifications
        cat > $dest/specifications/active_record_query_trace-1.8.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "active_record_query_trace"
      s.version = "1.8"
      s.summary = "active_record_query_trace"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
