# pg 1.6.2
{ lib, stdenv, ruby, pkgs }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
  overlay = import ../../../overlays/pg.nix { inherit pkgs ruby; };
  overlayDeps = if builtins.isList overlay then overlay else overlay.deps or [];
  overlayBuildPhase = if builtins.isAttrs overlay && overlay ? buildPhase then overlay.buildPhase else null;
in

stdenv.mkDerivation {
  pname = "pg";
  version = "1.6.2";
  src = builtins.path { path = ./source; name = "pg-1.6.2-source"; };

  nativeBuildInputs = [ ruby ] ++ overlayDeps;

  buildPhase = if overlayBuildPhase != null then overlayBuildPhase else ''
    for extconf in $(find ext -name extconf.rb 2>/dev/null); do
      dir=$(dirname "$extconf")
      echo "Building extension in $dir"
      (cd "$dir" && ruby extconf.rb && make -j$NIX_BUILD_CORES)
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

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/pg-1.6.2
    cp -r . $dest/gems/pg-1.6.2/
    local extdir=$dest/extensions/${arch}/${rubyVersion}/pg-1.6.2
    mkdir -p $extdir
    find . -name '*.so' -path '*/lib/*' | while read so; do
      cp "$so" "$extdir/"
    done
    local gp="${stdenv.hostPlatform.parsed.cpu.name}-${stdenv.hostPlatform.parsed.kernel.name}"
    if [ "${stdenv.hostPlatform.parsed.abi.name}" != "unknown" ]; then
      gp="$gp-${stdenv.hostPlatform.parsed.abi.name}"
    fi
    ln -s pg-1.6.2 $dest/gems/pg-1.6.2-$gp
    ln -s pg-1.6.2 $dest/extensions/${arch}/${rubyVersion}/pg-1.6.2-$gp
    mkdir -p $dest/specifications
    cat > $dest/specifications/pg-1.6.2.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "pg"
  s.version = "1.6.2"
  s.summary = "pg"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
    cat > $dest/specifications/pg-1.6.2-$gp.gemspec <<PLATSPEC
Gem::Specification.new do |s|
  s.name = "pg"
  s.version = "1.6.2"
  s.platform = "$gp"
  s.summary = "pg"
  s.require_paths = ["lib"]
  s.files = []
end
PLATSPEC
  '';
}
