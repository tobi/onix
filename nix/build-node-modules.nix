{
  pkgs,
  lib,
  nodePackages,
  project,
  lockfile,
  projectRoot,
  scriptPolicy ? "none",
  packageManager ? null,
  pnpmDepsHash ? "",
  pnpmWorkspaces ? [ ],
  workspacePaths ? [ ],
  nodeConfig ? { },
  globalDepsKey ? null,
  nodeVersionMajor ? null,
  pnpmVersionMajor ? null,
}:

let
  safeProject = lib.replaceStrings [ "/" ":" "@" ] [ "_" "_" "_" ] (
    if project != null then project else "project"
  );
  sourceRoot =
    if lockfile != null && builtins.pathExists lockfile then builtins.dirOf lockfile else projectRoot;
  lockfileBaseName =
    if lockfile != null && builtins.pathExists lockfile then
      builtins.baseNameOf (toString lockfile)
    else
      "pnpm-lock.yaml";
  ignoredSourcePrefixes = [
    ".git"
    "node_modules"
    "nix"
    "packagesets"
  ];
  isIgnoredPath =
    rel:
    rel == ".node_modules_id"
    || builtins.any (prefix: rel == prefix || lib.hasPrefix "${prefix}/" rel) ignoredSourcePrefixes;
  sourceFilter =
    base: path: _type:
    let
      abs = toString path;
      root = toString base;
      rel = if abs == root then "" else lib.removePrefix (root + "/") abs;
    in
    rel == "" || !(isIgnoredPath rel);
  nodePackagesValues = builtins.attrValues nodePackages;
  nodePackageNames = lib.unique (builtins.map (pkg: pkg.name) nodePackagesValues);
  nodeConfigFromBuild =
    base: overrides:
    let
      merge_lists = name: lib.unique ((base.${name} or [ ]) ++ (overrides.${name} or [ ]));
      merge_scripts =
        name:
        let
          base_script = base.${name} or "";
          override_script = overrides.${name} or "";
          scripts = [
            base_script
            override_script
          ];
        in
        lib.concatStringsSep "\n" (lib.filter (s: s != "") scripts);
      merge_phase =
        name:
        let
          base_phase = base.${name} or "";
          override_phase = overrides.${name} or "";
        in
        if override_phase != "" then override_phase else base_phase;
    in
    {
      deps = merge_lists "deps";
      preBuild = merge_scripts "preBuild";
      postBuild = merge_scripts "postBuild";
      postInstall = merge_scripts "postInstall";
      installFlags = merge_lists "installFlags";
      buildPhase = merge_phase "buildPhase";
    };
  inferredNodeConfigs = builtins.foldl' (
    acc: pkg:
    if !(pkg ? buildConfig) then
      acc
    else
      let
        existing = if acc ? "${pkg.name}" then acc.${pkg.name} else { };
        merged = nodeConfigFromBuild existing pkg.buildConfig;
      in
      acc
      // {
        "${pkg.name}" = merged;
      }
  ) { } nodePackagesValues;
  nodeConfigPairs = map (
    name:
    let
      inferred = inferredNodeConfigs.${name} or { };
      override = nodeConfig.${name} or { };
      merged = if inferred == { } then override else nodeConfigFromBuild inferred override;
    in
    {
      inherit name;
      value = merged;
    }
  ) nodePackageNames;
  nodeConfigs = builtins.listToAttrs nodeConfigPairs;
  nodeOverlayDeps = lib.unique (
    lib.concatMap (cfg: cfg.deps or [ ]) (builtins.attrValues nodeConfigs)
  );
  nodePreBuild = lib.concatStringsSep "\n" (
    lib.concatMap (cfg: lib.optionals (cfg ? preBuild) [ cfg.preBuild ]) (
      builtins.attrValues nodeConfigs
    )
  );
  nodePostBuild = lib.concatStringsSep "\n" (
    lib.concatMap (cfg: lib.optionals (cfg ? postBuild) [ cfg.postBuild ]) (
      builtins.attrValues nodeConfigs
    )
  );
  nodePostInstall = lib.concatStringsSep "\n" (
    lib.concatMap (cfg: lib.optionals (cfg ? postInstall) [ cfg.postInstall ]) (
      builtins.attrValues nodeConfigs
    )
  );
  nodeInstallFlags = lib.unique (
    lib.concatMap (cfg: cfg.installFlags or [ ]) (builtins.attrValues nodeConfigs)
  );
  nodeBuildPhases = lib.unique (
    lib.filter (s: s != "") (map (cfg: cfg.buildPhase or "") (builtins.attrValues nodeConfigs))
  );
  customBuildPhase = if nodeBuildPhases == [ ] then null else builtins.head nodeBuildPhases;
  nodeMajor = if nodeVersionMajor == null then 0 else nodeVersionMajor;
  pnpmMajor = if pnpmVersionMajor == null then 0 else pnpmVersionMajor;
  pnpmPackage =
    if pnpmMajor == 0 then
      pkgs.pnpm
    else if pnpmMajor == 8 then
      pkgs.pnpm_8 or pkgs.pnpm
    else if pnpmMajor == 9 then
      pkgs.pnpm_9 or pkgs.pnpm
    else if pnpmMajor == 10 then
      pkgs.pnpm_10 or pkgs.pnpm
    else
      throw "Unsupported pnpm major ${toString pnpmMajor}; supported majors: 8, 9, 10";
  computedGlobalKey =
    if globalDepsKey != null then
      globalDepsKey
    else
      "lock=${pnpmDepsHash};pnpm=${toString pnpmMajor};node=${toString nodeMajor}";
  overlayDigest = builtins.hashString "sha256" (builtins.toJSON nodeConfigs);
  workspaceDigest = builtins.hashString "sha256" (builtins.toJSON workspacePaths);
  artifactIdentity = lib.concatStringsSep ";" [
    computedGlobalKey
    "system=${pkgs.stdenv.hostPlatform.system}"
    "script=${scriptPolicy}"
    "overlay=${overlayDigest}"
    "workspace=${workspaceDigest}"
  ];
  filteredSourceRoot = lib.cleanSourceWith {
    src = sourceRoot;
    filter = sourceFilter sourceRoot;
  };
  normalizedSourceRoot =
    if lockfile != null && builtins.pathExists lockfile && lockfileBaseName != "pnpm-lock.yaml" then
      pkgs.runCommand "onix-${safeProject}-source-root" { } ''
        cp -R ${filteredSourceRoot}/. "$out/"
        chmod -R +w "$out"
        cp ${lockfile} "$out/pnpm-lock.yaml"
      ''
    else
      filteredSourceRoot;
  filteredProjectRoot = lib.cleanSourceWith {
    src = projectRoot;
    filter = sourceFilter projectRoot;
  };
  normalizedProjectRoot =
    if lockfile != null && builtins.pathExists lockfile && lockfileBaseName != "pnpm-lock.yaml" then
      pkgs.runCommand "onix-${safeProject}-project-root" { } ''
        cp -R ${filteredProjectRoot}/. "$out/"
        chmod -R +w "$out"
        cp ${lockfile} "$out/pnpm-lock.yaml"
      ''
    else
      filteredProjectRoot;
  isScriptless = scriptPolicy == "none";
  baseInstallFlags = if isScriptless then [ "--ignore-scripts" ] else [ ];
  installFlags = lib.unique (baseInstallFlags ++ nodeInstallFlags);
  workspaceFilters = map (w: "--filter=${w}") pnpmWorkspaces;
  fetchPnpmDeps =
    if pkgs ? fetchPnpmDeps then pkgs.fetchPnpmDeps
    else pnpmPackage.fetchDeps;
  pnpmDeps = fetchPnpmDeps {
    pname = "onix-pnpm-deps-node${toString nodeMajor}-pnpm${toString pnpmMajor}";
    src = normalizedSourceRoot;
    fetcherVersion = 3;
    hash = pnpmDepsHash;
    prePnpmInstall = ''
      pnpm config set package-import-method clone-or-copy
      pnpm config set side-effects-cache false
      pnpm config set update-notifier false
      pnpm config set manage-package-manager-versions false
      pnpm config set engine-strict false
    ''
    + nodePreBuild
    + nodePostBuild;
    pnpmInstallFlags = [ "--force" ];
    pnpmWorkspaces = pnpmWorkspaces;
  };

in
assert pnpmDepsHash != "";
assert builtins.length nodeBuildPhases <= 1;
pkgs.stdenv.mkDerivation {
  pname = "onix-${safeProject}-node-modules";
  version = "0";

  src = normalizedProjectRoot;

  nativeBuildInputs = [
    pkgs.nodejs
    pnpmPackage
    pkgs.zstd
  ]
  ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [ pkgs.patchelf ]
  ++ nodeOverlayDeps;

  pnpmDeps = pnpmDeps;
  dontBuild = true;
  preBuild = nodePreBuild;
  postBuild = nodePostBuild;
  postInstall = nodePostInstall;

  installPhase = ''
    runHook preBuild

    export HOME="$TMPDIR/pnpm-home"
    export NPM_CONFIG_USERCONFIG="$TMPDIR/onix-npmrc"
    export STORE_PATH="$TMPDIR/pnpm-store"
    export NODE_PATH=""
    mkdir -p "$HOME" "$STORE_PATH"

    ca_file="${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
    if [ -z "''${SSL_CERT_FILE:-}" ] || [ ! -f "''${SSL_CERT_FILE:-}" ]; then
      export SSL_CERT_FILE="$ca_file"
    fi
    if [ -z "''${NODE_EXTRA_CA_CERTS:-}" ] || [ ! -f "''${NODE_EXTRA_CA_CERTS:-}" ]; then
      export NODE_EXTRA_CA_CERTS="$ca_file"
    fi
    if [ -f "$SSL_CERT_FILE" ]; then
      export NPM_CONFIG_CAFILE="$SSL_CERT_FILE"
    fi

    # Preserve project-local npmrc if present (e.g. registry mirror config).
    if [ -f .npmrc ]; then
      cp .npmrc "$NPM_CONFIG_USERCONFIG"
    fi

    # Inject runtime secrets only through environment and never write them to checked-in artifacts.
    if [ -n "$ONIX_NPM_TOKEN_LINES" ]; then
      printf '%s\n' "$ONIX_NPM_TOKEN_LINES" >> "$NPM_CONFIG_USERCONFIG"
    fi

    if [ -f "$pnpmDeps/pnpm-store.tar.zst" ]; then
      tar --zstd -xf "$pnpmDeps/pnpm-store.tar.zst" -C "$STORE_PATH"
    else
      cp -R "$pnpmDeps/"* "$STORE_PATH/"
    fi
    chmod -R +w "$STORE_PATH"

    pnpm config set store-dir "$STORE_PATH"
    pnpm config set package-import-method clone-or-copy
    pnpm config set side-effects-cache false
    pnpm config set update-notifier false
    pnpm config set manage-package-manager-versions false
    pnpm config set engine-strict false

    ${
      if customBuildPhase == null then
        ''
          # Install from the pre-fetched dependency graph.
          # Keep script execution policy aligned with importer policy:
          #   none => ignore all lifecycle scripts
          #   allowed => run lifecycle scripts (pnpm will honor workspace allowlists when set)
          if [ -n "$NIX_NPM_REGISTRY" ]; then
            pnpm install --force --registry="$NIX_NPM_REGISTRY" ${lib.concatStringsSep " " installFlags} ${lib.concatStringsSep " " workspaceFilters}
          else
            pnpm install --force ${lib.concatStringsSep " " installFlags} ${lib.concatStringsSep " " workspaceFilters}
          fi
        ''
      else
        customBuildPhase
    }

    patchShebangs node_modules/{*,.*}
    runHook postBuild
    if [ -n "${lib.concatStringsSep " " (map lib.escapeShellArg workspacePaths)}" ]; then
      mkdir -p "$out"
      for rel in ${lib.concatStringsSep " " (map lib.escapeShellArg workspacePaths)}; do
        abs_path="$(cd "$PWD/$rel" 2>/dev/null && pwd)"
        if [ -z "$abs_path" ]; then
          echo "Skipping workspace path that does not exist: $rel" >&2
          continue
        fi
        case "$abs_path" in
          "$PWD" | "$PWD"/*) ;;
          *)
            echo "Skipping workspace path outside project root: $rel" >&2
            continue
            ;;
        esac
        rel_out="$out"
        if [ "$abs_path" != "$PWD" ]; then
          rel_out="$out/''${abs_path#$PWD/}"
        fi
        if [ -e "$abs_path" ]; then
          mkdir -p "$(dirname "$rel_out")"
          cp -a "$abs_path" "$rel_out"
        fi
      done
    fi

    mkdir -p "$out/node_modules"
    cp -a node_modules/. "$out/node_modules/"
    echo "${artifactIdentity}" > "$out/.node_modules_id"

    runHook postInstall
  '';
}
