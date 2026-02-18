{ pkgs, lib, nodePackages, project, lockfile, projectRoot, scriptPolicy ? "none", packageManager ? null, pnpmDepsHash ? "", pnpmWorkspaces ? [ ], workspacePaths ? [ ] }:

let
  safeProject = lib.replaceStrings [ "/" ":" "@" ] [ "_" "_" "_" ] (if project != null then project else "project");
  sourceRoot = if lockfile != null && builtins.pathExists lockfile then builtins.dirOf lockfile else projectRoot;
  ignoredSourcePrefixes = [ ".git" "node_modules" "nix" "packagesets" ];
  isIgnoredPath = rel:
    rel == ".node_modules_id" ||
    builtins.any (prefix: rel == prefix || lib.hasPrefix "${prefix}/" rel) ignoredSourcePrefixes;
  sourceFilter = base: path: _type:
    let
      abs = toString path;
      root = toString base;
      rel =
        if abs == root
        then ""
        else lib.removePrefix (root + "/") abs;
    in
    rel == "" || !(isIgnoredPath rel);
  filteredSourceRoot = lib.cleanSourceWith {
    src = sourceRoot;
    filter = sourceFilter sourceRoot;
  };
  filteredProjectRoot = lib.cleanSourceWith {
    src = projectRoot;
    filter = sourceFilter projectRoot;
  };
  isScriptless = scriptPolicy == "none";
  installFlags = if isScriptless then [ "--ignore-scripts" ] else [ ];
  workspaceFilters = map (w: "--filter=${w}") pnpmWorkspaces;
  pnpmDeps = pkgs.fetchPnpmDeps {
    pname = "onix-${safeProject}-pnpm-deps";
    version = "0";
    src = filteredSourceRoot;
    pnpm = pkgs.pnpm;
    fetcherVersion = 3;
    hash = pnpmDepsHash;
    prePnpmInstall = ''
      pnpm config set package-import-method clone-or-copy
      pnpm config set side-effects-cache false
      pnpm config set update-notifier false
    '';
    pnpmInstallFlags = [ "--force" ];
    pnpmWorkspaces = pnpmWorkspaces;
  };

in
assert pnpmDepsHash != "";
pkgs.stdenv.mkDerivation {
  pname = "onix-${safeProject}-node-modules";
  version = "0";

  src = filteredProjectRoot;

  nativeBuildInputs = [
    pkgs.nodejs
    pkgs.pnpm
    pkgs.zstd
  ];

  pnpmDeps = pnpmDeps;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

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

    # Keep pnpm packageManager checks from failing builds for lockfiles that pin another pnpm minor.
    if [ -f package.json ]; then
      node -e 'const fs = require("fs"); const p = JSON.parse(fs.readFileSync("package.json", "utf8")); delete p.packageManager; fs.writeFileSync("package.json", JSON.stringify(p, null, 2) + "\n");'
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

    runHook prePnpmInstall

    # Install from the pre-fetched dependency graph.
    # Keep script execution policy aligned with importer policy:
    #   none => ignore all lifecycle scripts
    #   allowed/all => run lifecycle scripts (pnpm will honor workspace allowlists when set)
    if [ -n "$NIX_NPM_REGISTRY" ]; then
      pnpm install --force --registry="$NIX_NPM_REGISTRY" ${lib.concatStringsSep " " installFlags} ${lib.concatStringsSep " " workspaceFilters}
    else
      pnpm install --force ${lib.concatStringsSep " " installFlags} ${lib.concatStringsSep " " workspaceFilters}
    fi

    patchShebangs node_modules/{*,.*}
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
    echo "${pnpmDepsHash}/${project}/${scriptPolicy}" > "$out/.node_modules_id"

    runHook postInstall
  '';
}
