#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# stackprof 0.2.27
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
  pname = "stackprof";
  version = "0.2.27";
  src = builtins.path {
    path = ./source;
    name = "stackprof-0.2.27-source";
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
      for ext in so bundle; do
        if [ -n "$target_name" ] && [ -f "$dir/$target_name.$ext" ]; then
          mkdir -p "lib$target_prefix"
          cp "$dir/$target_name.$ext" "lib$target_prefix/$target_name.$ext"
          echo "Installed $dir/$target_name.$ext -> lib$target_prefix/$target_name.$ext"
        fi
      done
    done
  '';

  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/stackprof-0.2.27
        cp -r . $dest/gems/stackprof-0.2.27/
        local extdir=$dest/extensions/${arch}/${rubyVersion}/stackprof-0.2.27
        mkdir -p $extdir
        find . \( -name '*.so' -o -name '*.bundle' \) -path '*/lib/*' | while read so; do
          cp "$so" "$extdir/"
        done
        local cpu="${stdenv.hostPlatform.parsed.cpu.name}"
        if [ "$cpu" = "aarch64" ]; then cpu="arm64"; fi
        local gp="$cpu-${stdenv.hostPlatform.parsed.kernel.name}"
        if [ "${stdenv.hostPlatform.parsed.abi.name}" != "unknown" ]; then
          gp="$gp-${stdenv.hostPlatform.parsed.abi.name}"
        fi
        ln -s stackprof-0.2.27 $dest/gems/stackprof-0.2.27-$gp
        ln -s stackprof-0.2.27 $dest/extensions/${arch}/${rubyVersion}/stackprof-0.2.27-$gp
        if [ "${stdenv.hostPlatform.parsed.kernel.name}" = "darwin" ]; then
          ln -sf stackprof-0.2.27 $dest/gems/stackprof-0.2.27-universal-darwin
          ln -sf stackprof-0.2.27 $dest/extensions/${arch}/${rubyVersion}/stackprof-0.2.27-universal-darwin
        fi
        mkdir -p $dest/specifications
        cat > $dest/specifications/stackprof-0.2.27.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "stackprof"
      s.version = "0.2.27"
      s.summary = "stackprof"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["stackprof", "stackprof-flamegraph.pl", "stackprof-gprof2dot.py"]
      s.files = []
    end
    EOF
        cat > $dest/specifications/stackprof-0.2.27-$gp.gemspec <<PLATSPEC
    Gem::Specification.new do |s|
      s.name = "stackprof"
      s.version = "0.2.27"
      s.platform = "$gp"
      s.summary = "stackprof"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["stackprof", "stackprof-flamegraph.pl", "stackprof-gprof2dot.py"]
      s.files = []
    end
    PLATSPEC
        if [ "${stdenv.hostPlatform.parsed.kernel.name}" = "darwin" ]; then
          cat > $dest/specifications/stackprof-0.2.27-universal-darwin.gemspec <<'UNISPEC'
    Gem::Specification.new do |s|
      s.name = "stackprof"
      s.version = "0.2.27"
      s.platform = "universal-darwin"
      s.summary = "stackprof"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["stackprof", "stackprof-flamegraph.pl", "stackprof-gprof2dot.py"]
      s.files = []
    end
    UNISPEC
        fi
        mkdir -p $dest/bin
        cat > $dest/bin/stackprof <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("stackprof", "stackprof", "0.2.27")
    BINSTUB
        chmod +x $dest/bin/stackprof
        cat > $dest/bin/stackprof-flamegraph.pl <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("stackprof", "stackprof-flamegraph.pl", "0.2.27")
    BINSTUB
        chmod +x $dest/bin/stackprof-flamegraph.pl
        cat > $dest/bin/stackprof-gprof2dot.py <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("stackprof", "stackprof-gprof2dot.py", "0.2.27")
    BINSTUB
        chmod +x $dest/bin/stackprof-gprof2dot.py
  '';
}
