#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ddtrace 1.23.1
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
  pname = "ddtrace";
  version = "1.23.1";
  src = builtins.path {
    path = ./source;
    name = "ddtrace-1.23.1-source";
  };

  nativeBuildInputs = [ ruby ];

  buildPhase = ''
    extconfFlags=""
    for extconf in $(find ext -name extconf.rb 2>/dev/null); do
      dir=$(dirname "$extconf")
      echo "Building extension in $dir"
      (cd "$dir" && ruby extconf.rb $extconfFlags && make -j$NIX_BUILD_CORES)
    done
    for makefile in $(find ext -name Makefile 2>/dev/null); do
      dir=$(dirname "$makefile")
      target_name=$(sed -n 's/^TARGET = //p' "$makefile")
      target_prefix=$(sed -n 's/^target_prefix = //p' "$makefile")
      if [ -n "$target_name" ] && [ -f "$dir/$target_name.so" ]; then
        mkdir -p "lib$target_prefix"
        cp "$dir/$target_name.so" "lib$target_prefix/$target_name.so"
        echo "Installed $dir/$target_name.so -> lib$target_prefix/$target_name.so"
      fi
    done
  '';

  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/ddtrace-1.23.1
        cp -r . $dest/gems/ddtrace-1.23.1/
        local extdir=$dest/extensions/${arch}/${rubyVersion}/ddtrace-1.23.1
        mkdir -p $extdir
        find . -name '*.so' -path '*/lib/*' | while read so; do
          cp "$so" "$extdir/"
        done
        local gp="${stdenv.hostPlatform.parsed.cpu.name}-${stdenv.hostPlatform.parsed.kernel.name}"
        if [ "${stdenv.hostPlatform.parsed.abi.name}" != "unknown" ]; then
          gp="$gp-${stdenv.hostPlatform.parsed.abi.name}"
        fi
        ln -s ddtrace-1.23.1 $dest/gems/ddtrace-1.23.1-$gp
        ln -s ddtrace-1.23.1 $dest/extensions/${arch}/${rubyVersion}/ddtrace-1.23.1-$gp
        mkdir -p $dest/specifications
        cat > $dest/specifications/ddtrace-1.23.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "ddtrace"
      s.version = "1.23.1"
      s.summary = "ddtrace"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["ddtracerb", "ddprofrb"]
      s.files = []
    end
    EOF
        cat > $dest/specifications/ddtrace-1.23.1-$gp.gemspec <<PLATSPEC
    Gem::Specification.new do |s|
      s.name = "ddtrace"
      s.version = "1.23.1"
      s.platform = "$gp"
      s.summary = "ddtrace"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["ddtracerb", "ddprofrb"]
      s.files = []
    end
    PLATSPEC
        mkdir -p $dest/bin
        cat > $dest/bin/ddtracerb <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("ddtrace", "ddtracerb", "1.23.1")
    BINSTUB
        chmod +x $dest/bin/ddtracerb
        cat > $dest/bin/ddprofrb <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("ddtrace", "ddprofrb", "1.23.1")
    BINSTUB
        chmod +x $dest/bin/ddprofrb
  '';
}
