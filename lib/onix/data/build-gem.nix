# build-gem.nix — generic builder for any Ruby gem
#
# Usage:
#   buildGem = import ./build-gem.nix { inherit pkgs ruby; };
#   buildGem {
#     gemName = "nokogiri";
#     version = "1.19.0";
#     source = { type = "gem"; remotes = [ "https://rubygems.org" ]; sha256 = "..."; };
#   }

{ pkgs, ruby }:

let
  inherit (pkgs) lib stdenv fetchurl fetchgit;
  rubyVersion = "${ruby.version.majMin}.0";
in

{
  gemName,
  version,
  platform ? null,
  source,
  subdir ? ".",              # subdirectory within git repo (monorepo support)
  nativeBuildInputs ? [],
  buildInputs ? [],
  buildGems ? [],
  extconfFlags ? "",
  beforeBuild ? "",
  afterBuild ? "",
  buildPhase ? null,
  postInstall ? "",
  requirePaths ? [ "lib" ],
  executables ? [],
  bindir ? "exe",
  skip ? false,
}:

let
  key = "${gemName}-${version}";
  bundle_path = "ruby/${rubyVersion}";
  arch = stdenv.hostPlatform.system;

  slug = if platform != null then "${gemName}-${version}-${platform}" else "${gemName}-${version}";

  src =
    if source.type == "gem" then
      fetchurl {
        urls = map (remote: "${remote}/gems/${slug}.gem")
          (source.remotes or [ "https://rubygems.org" ]);
        inherit (source) sha256;
      }
    else if source.type == "git" then
      builtins.fetchGit {
        inherit (source) url rev;
        allRefs = true;
        submodules = source.fetchSubmodules or false;
      }
    else
      throw "buildGem: unknown source type '${source.type}' for ${gemName}";

  isPlatformGem = platform != null && source.type == "gem";

  # Unpack .gem into a source directory
  sourceDir =
    if source.type == "gem" then
      pkgs.runCommand "${key}-source" { inherit src; nativeBuildInputs = [ ruby ]; } (''
        mkdir -p $out
        gem unpack $src --target=tmp
        cp -r tmp/*/* $out/ 2>/dev/null || cp -r tmp/* $out/
      '' + lib.optionalString (!isPlatformGem) ''
        find $out -name '*.so' -o -name '*.bundle' -o -name '*.dylib' | xargs rm -f 2>/dev/null || true
      '')
    else if subdir != "." then
      # Git monorepo: extract just the gem's subdirectory
      src + "/${subdir}"
    else
      src;

  gemPathSetup = lib.optionalString (buildGems != []) ''
    export GEM_PATH="${lib.concatMapStringsSep ":" (g: "${g}/${bundle_path}") buildGems}''${GEM_PATH:+:$GEM_PATH}"
  '';

  defaultBuildPhase = ''
    ${beforeBuild}
    extconfFlags="${extconfFlags}"
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
        fi
      done
    done
    ${afterBuild}
  '';

  rp = builtins.concatStringsSep ", " (map (p: ''"${p}"'') requirePaths);

in
if skip then
  # Produce an empty derivation for gems we can't build
  pkgs.runCommand key {} ''
    mkdir -p $out/${bundle_path}/gems/${key}
    mkdir -p $out/${bundle_path}/specifications
    cat > $out/${bundle_path}/specifications/${key}.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "${gemName}"
      s.version = "${version}"
      s.summary = "${gemName} (skipped)"
      s.require_paths = [${rp}]
      s.files = []
    end
    EOF
  ''
else
stdenv.mkDerivation {
  pname = gemName;
  inherit version;
  src = sourceDir;

  nativeBuildInputs = [ ruby ] ++ nativeBuildInputs;
  inherit buildInputs;
  dontConfigure = true;

  buildPhase =
    if isPlatformGem then "true"  # platform gems have prebuilt binaries
    else gemPathSetup + (
      if buildPhase != null then buildPhase
      else if builtins.pathExists (sourceDir + "/ext") then defaultBuildPhase
      else "true"
    );

  passthru = { inherit bundle_path; };

  installPhase = ''
    local dest=$out/${bundle_path}
    mkdir -p $dest/gems/${key}
    cp -r . $dest/gems/${key}/

    # Extensions: copy .so/.bundle and create platform links
    local has_ext=0
    find . \( -name '*.so' -o -name '*.bundle' \) -path '*/lib/*' 2>/dev/null | head -1 | grep -q . && has_ext=1

    if [ "$has_ext" = "1" ]; then
      local extdir=$dest/extensions/${arch}/${rubyVersion}/${key}
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
      ln -sf ${key} $dest/gems/${key}-$gp
      ln -sf ${key} $dest/extensions/${arch}/${rubyVersion}/${key}-$gp
      if [ "${stdenv.hostPlatform.parsed.kernel.name}" = "darwin" ]; then
        ln -sf ${key} $dest/gems/${key}-universal-darwin
        ln -sf ${key} $dest/extensions/${arch}/${rubyVersion}/${key}-universal-darwin
      fi
    fi

    # Gemspecs
    mkdir -p $dest/specifications
    cat > $dest/specifications/${key}.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "${gemName}"
      s.version = "${version}"
      s.summary = "${gemName}"
      s.require_paths = [${rp}]
      s.files = []
    end
    EOF

    if [ "$has_ext" = "1" ]; then
      local cpu="${stdenv.hostPlatform.parsed.cpu.name}"
      if [ "$cpu" = "aarch64" ]; then cpu="arm64"; fi
      local gp="$cpu-${stdenv.hostPlatform.parsed.kernel.name}"
      if [ "${stdenv.hostPlatform.parsed.abi.name}" != "unknown" ]; then
        gp="$gp-${stdenv.hostPlatform.parsed.abi.name}"
      fi
      cat > $dest/specifications/${key}-$gp.gemspec <<PLATSPEC
    Gem::Specification.new do |s|
      s.name = "${gemName}"
      s.version = "${version}"
      s.platform = "$gp"
      s.summary = "${gemName}"
      s.require_paths = [${rp}]
      s.files = []
    end
    PLATSPEC
      if [ "${stdenv.hostPlatform.parsed.kernel.name}" = "darwin" ]; then
        cat > $dest/specifications/${key}-universal-darwin.gemspec <<'UNISPEC'
    Gem::Specification.new do |s|
      s.name = "${gemName}"
      s.version = "${version}"
      s.platform = "universal-darwin"
      s.summary = "${gemName}"
      s.require_paths = [${rp}]
      s.files = []
    end
    UNISPEC
      fi
    fi

    ${lib.optionalString (executables != []) ''
      mkdir -p $dest/bin
      ${builtins.concatStringsSep "\n" (map (exe: ''
        cat > $dest/bin/${exe} <<'BINSTUB'
        #!/usr/bin/env ruby
        require "rubygems"
        load Gem.bin_path("${gemName}", "${exe}", "${version}")
        BINSTUB
        chmod +x $dest/bin/${exe}
      '') executables)}
    ''}

    ${postInstall}
  '';
}
