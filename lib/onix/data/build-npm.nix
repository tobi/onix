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
  os ? [],
  cpu ? [],
  integrity ? null,       # tarball integrity (consumed by onix-link, not by Nix build)
}:

let
  key = "${pkgName}-${version}";

  npmOs = if stdenv.hostPlatform.isDarwin then "darwin"
          else if stdenv.hostPlatform.isLinux then "linux"
          else "unknown";
  npmCpu = if stdenv.hostPlatform.isx86_64 then "x64"
           else if stdenv.hostPlatform.isAarch64 then "arm64"
           else "unknown";
  matchesConstraint = wanted: current:
    builtins.any (w:
      let
        isNegation = lib.hasPrefix "!" w;
        value = lib.removePrefix "!" w;
      in
        if isNegation then current != value else current == value
    ) wanted;
  platformOk = (os == [] || matchesConstraint os npmOs)
            && (cpu == [] || matchesConstraint cpu npmCpu);

  # npm tarballs contain a package/ prefix directory
  src =
    if source.type == "tarball" then
      fetchurl {
        # Use explicit tarball URL from lockfile when available (private registries),
        # otherwise construct from registry URL
        urls = if source ? url then [ source.url ]
          else map (remote: "${remote}/${pkgName}/-/${builtins.baseNameOf pkgName}-${version}.tgz")
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
        tar xzf $src --no-same-permissions --strip-components=1 -C $out
      ''
    else if subdir != "." then
      src + "/${subdir}"
    else
      src;

  nodeModulesSetup = lib.optionalString (buildPackages != []) ''
    mkdir -p node_modules
    ${lib.concatMapStringsSep "\n" (p:
      "ln -sf ${p} node_modules/${p.pname or (builtins.parseDrvName p.name).name}"
    ) buildPackages}
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

  # Pure JS: no native addons, no custom build, no build-time deps
  isPureJs = !hasNative && buildPhase == null && buildPackages == []
    && beforeBuild == "" && afterBuild == "" && postInstall == "";

  # Bin linking: create node_modules/.bin/ symlinks from package.json bin field.
  # Uses jq (not Node.js) to avoid spawning a heavy runtime per package.
  binLinkScript = if bin != {} then ''
    mkdir -p "$out/node_modules/.bin"
    ${lib.concatStringsSep "\n" (lib.mapAttrsToList (name: path: ''
      ln -sf "$dest/${path}" "$out/node_modules/.bin/${name}"
    '') bin)}
  '' else ''
    if [ -f "$dest/package.json" ]; then
      ${pkgs.jq}/bin/jq -r '
        if .bin | type == "string" then
          "\(.name | split("/") | last)\t\(.bin)"
        elif .bin | type == "object" then
          .bin | to_entries[] | "\(.key)\t\(.value)"
        else empty end
      ' "$dest/package.json" | while IFS=$'\t' read -r bin_name bin_path; do
        mkdir -p "$out/node_modules/.bin"
        ln -sf "$dest/$bin_path" "$out/node_modules/.bin/$bin_name"
      done
    fi
  '';

  # .onix-manifest generation shared by both paths (single node invocation, no per-file forks)
  manifestScript = ''
    ${lib.optionalString (integrity != null) ''
      printf '#integrity %s\n' "${integrity}" > "$out/.onix-manifest"
    ''}
    ${nodejs}/bin/node -e '
      const fs = require("fs"), path = require("path"), crypto = require("crypto");
      const pkgDir = process.argv[1];
      const manifest = process.argv[2];
      const lines = [];
      function walk(dir, rel) {
        for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
          const full = path.join(dir, e.name);
          const r = rel ? rel + "/" + e.name : e.name;
          if (e.isDirectory()) walk(full, r);
          else if (e.isFile()) {
            const buf = fs.readFileSync(full);
            const hash = crypto.createHash("sha512").update(buf).digest("hex").slice(0, 128);
            const st = fs.statSync(full);
            const mode = (st.mode & 0o777).toString(8);
            lines.push(r + "\t" + hash + "\t" + mode + "\t" + st.size);
          }
        }
      }
      walk(pkgDir, "");
      lines.sort();
      fs.appendFileSync(manifest, lines.join("\n") + "\n");
    ' "$out/node_modules/${pkgName}" "$out/.onix-manifest"
  '';

in
if skip || !platformOk then
  # Produce an empty derivation for packages we can't build
  pkgs.runCommand key {} (''
    dest="$out/node_modules/${pkgName}"
    mkdir -p "$dest"
    echo '{"name":"${pkgName}","version":"${version}"}' > "$dest/package.json"
  '' + manifestScript)
else if isPureJs then
  # Fast path: pure JS tarballs unpack directly — no intermediate sourceDir derivation
  pkgs.runCommand key {
    src = if source.type == "tarball" then src else sourceDir;
  } (''
    dest="$out/node_modules/${pkgName}"
    mkdir -p "$dest"
  '' + (if source.type == "tarball" then ''
    tar xzf "$src" --no-same-permissions --strip-components=1 -C "$dest"
  '' else ''
    cp -r "$src"/. "$dest"/
  '')
    + binLinkScript
    + manifestScript
  )
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
      else "true"
    );

  installPhase = ''
    runHook preInstall
    local dest="$out/node_modules/${pkgName}"
    mkdir -p "$dest"
    cp -r . "$dest"/

    ${binLinkScript}
    ${postInstall}
    runHook postInstall

    ${manifestScript}
  '';

  meta = {
    description = "${pkgName} npm package";
    platforms = lib.platforms.all;
  };
}
