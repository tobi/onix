# build-npm.nix — generic builder for any npm package
#
# Usage:
#   buildNpm = import ./build-npm.nix { inherit pkgs nodejs; };
#   buildNpm {
#     pkgName = "react";
#     version = "19.1.0";
#     source = { type = "tarball"; remotes = [ "https://registry.npmjs.org" ]; sha256 = "..."; };
#   }

{ pkgs, nodejs }:

let
  inherit (pkgs) lib stdenv fetchurl;
in

{
  pkgName,
  version,
  source,
  subdir ? ".",              # subdirectory within git repo (monorepo support)
  bin ? {},                  # { "cli-name" = "./bin/cli.js"; }
  hasNative ? false,         # has node-gyp / napi native addon?
  nativeBuildInputs ? [],
  buildInputs ? [],
  buildPackages ? [],        # npm packages needed at build time (analogous to buildGems)
  buildFlags ? "",
  beforeBuild ? "",
  afterBuild ? "",
  buildPhase ? null,
  postInstall ? "",
  skip ? false,
}:

let
  key = "${pkgName}-${version}";

  # npm tarballs contain a package/ prefix directory
  src =
    if source.type == "tarball" then
      fetchurl {
        urls = map (remote: "${remote}/${pkgName}/-/${builtins.baseNameOf pkgName}-${version}.tgz")
          (source.remotes or [ "https://registry.npmjs.org" ]);
        inherit (source) sha256;
      }
    else if source.type == "git" then
      builtins.fetchGit {
        inherit (source) url rev;
        allRefs = true;
        submodules = source.fetchSubmodules or false;
      }
    else
      throw "buildNpm: unknown source type '${source.type}' for ${pkgName}";

  # Unpack npm tarball into a source directory
  sourceDir =
    if source.type == "tarball" then
      pkgs.runCommand "${key}-source" { inherit src; } ''
        mkdir -p $out
        tar xzf $src --strip-components=1 -C $out
      ''
    else if subdir != "." then
      src + "/${subdir}"
    else
      src;

  nodeModulesSetup = lib.optionalString (buildPackages != []) ''
    mkdir -p node_modules
    ${builtins.concatStringsSep "\n" (map (p:
      "ln -sf ${p} node_modules/${p.pname or (builtins.parseDrvName p.name).name}"
    ) buildPackages)}
  '';

  defaultBuildPhase = ''
    ${beforeBuild}
    export HOME=$TMPDIR
    export npm_config_nodedir=${nodejs}
    export PYTHON=${pkgs.python3}/bin/python3
    export npm_config_python=${pkgs.python3}/bin/python3
    ${nodejs}/bin/node ${nodejs}/lib/node_modules/npm/node_modules/node-gyp/bin/node-gyp.js rebuild ${buildFlags}
    ${afterBuild}
  '';

in
if skip then
  # Produce an empty derivation for packages we can't build
  pkgs.runCommand key {} ''
    mkdir -p "$out/node_modules/${pkgName}"
    echo '{"name":"${pkgName}","version":"${version}"}' > "$out/node_modules/${pkgName}/package.json"
  ''
else
stdenv.mkDerivation {
  pname = pkgName;
  inherit version;
  src = sourceDir;

  nativeBuildInputs = [ nodejs ] ++ nativeBuildInputs
    ++ lib.optionals hasNative [ pkgs.python3 pkgs.pkg-config ];
  inherit buildInputs;
  dontConfigure = true;

  buildPhase = nodeModulesSetup + (
      if buildPhase != null then buildPhase
      else if hasNative then defaultBuildPhase
      else "true"  # pure JS — nothing to build
    );

  installPhase = ''
    runHook preInstall
    local dest="$out/node_modules/${pkgName}"
    mkdir -p "$dest"
    cp -r . "$dest"/

    # Create bin links from package.json (auto-detect at build time)
    # If explicit bin entries are passed, use those; otherwise read package.json
    ${if bin != {} then ''
      mkdir -p "$out/node_modules/.bin"
      ${builtins.concatStringsSep "\n" (lib.mapAttrsToList (name: path: ''
        ln -sf "$dest/${path}" "$out/node_modules/.bin/${name}"
      '') bin)}
    '' else ''
      if [ -f "$dest/package.json" ]; then
        ${nodejs}/bin/node -e "
          const pj = require('$dest/package.json');
          const fs = require('fs');
          const path = require('path');
          if (!pj.bin) process.exit(0);
          const bins = typeof pj.bin === 'string'
            ? { [pj.name.split('/').pop()]: pj.bin }
            : pj.bin;
          const binDir = path.join('$out', 'node_modules', '.bin');
          fs.mkdirSync(binDir, { recursive: true });
          for (const [name, target] of Object.entries(bins)) {
            const src = path.join('$dest', target);
            const link = path.join(binDir, name);
            try { fs.unlinkSync(link); } catch {}
            fs.symlinkSync(src, link);
          }
        "
      fi
    ''}

    ${postInstall}
    runHook postInstall
  '';

  meta = {
    description = "${pkgName} npm package";
  };
}
