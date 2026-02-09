# scint-to-nix — Justfile
#
# Usage:
#   just build                   # build every gem derivation
#   just build fizzy             # build all gems for an app + bundle-path
#   just test fizzy              # run app test suite

#   just lint fizzy              # run lint suite

set shell := ["bash", "-euo", "pipefail", "-c"]

ruby := "ruby_3_4"

# ── Build ──────────────────────────────────────────────────────────

# Build every gem derivation in the tree
[group('build')]
build app="":
    #!/usr/bin/env bash
    if [[ -n "{{app}}" ]]; then
        echo "Building all gems for {{app}}..."
        paths=$(nix-build --no-out-link --keep-going -E '
            let pkgs = import <nixpkgs> {};
                ruby = pkgs.{{ruby}};
                resolve = import ./nix/modules/resolve.nix;
                gems = resolve { inherit pkgs ruby; gemset = import ./nix/app/{{app}}.nix; };
            in builtins.attrValues gems
        ')
        n=$(echo "$paths" | wc -l)
        echo "$n gems built for {{app}}."
    else
        total=$(find nix/gem -mindepth 2 -maxdepth 2 -type d | wc -l)
        echo "Building $total gem derivations..."
        err=$(mktemp)
        nix-build --no-out-link --keep-going -E '
            let pkgs = import <nixpkgs> {};
                ruby = pkgs.{{ruby}};
                lib = pkgs.lib;
                dirs = builtins.attrNames (builtins.readDir ./nix/gem);
                versionsOf = name:
                    let entries = builtins.readDir (./nix/gem + "/${name}");
                        subdirs = lib.filterAttrs (k: v: v == "directory") entries;
                    in map (v: pkgs.callPackage (./nix/gem + "/${name}/${v}") { inherit ruby; })
                           (builtins.attrNames subdirs);
            in lib.concatMap versionsOf dirs
        ' >/dev/null 2>"$err" || true
        failed=$(grep -oP "'/nix/store/[^']+'" "$err" | sort -u | wc -l || echo 0)
        echo "$((total - failed))/$total built, $failed failed."
        if [[ $failed -gt 0 ]]; then
            grep 'nix log' "$err" >&2 || true
        fi
        rm -f "$err"
    fi

# Build a single gem (for debugging failures)
[group('build')]
build-gem app gem:
    nix-build --no-out-link -E 'let pkgs = import <nixpkgs> {}; ruby = pkgs.{{ruby}}; resolve = import ./nix/modules/resolve.nix; gems = resolve { inherit pkgs ruby; gemset = import ./nix/app/{{app}}.nix; }; in gems."{{gem}}"'

# ── Fetch & Generate ──────────────────────────────────────────────

# Fetch all gem sources into cache/
[group('generate')]
fetch:
    bin/fetch gems/

# Recreate source symlinks (after fresh clone)
[group('generate')]
link:
    #!/usr/bin/env bash
    n=0
    for d in nix/gem/*/*/; do
        [[ -d "$d" ]] || continue
        [[ "$(basename "$d")" == git-* ]] && continue
        name=$(basename "$(dirname "$d")")
        version=$(basename "$d")
        target="cache/sources/${name}-${version}"
        link="${d}source"
        if [[ -d "$target" && ! -e "$link" ]]; then
            ln -sf "$(cd "$target" && pwd)" "$link"
            n=$((n + 1))
        fi
    done
    echo "Linked $n source directories."

# Regenerate all gem derivations + selectors from cache
[group('generate')]
generate:
    bin/generate

# Generate an app gemset from a Gemfile.lock
[group('generate')]
generate-gemset app lockfile:
    bin/generate-gemset {{app}} {{lockfile}}

# Full pipeline: generate + gemset
[group('generate')]
regenerate app lockfile: generate (generate-gemset app lockfile)

# ── Test & Lint ────────────────────────────────────────────────────

# Run the app's test suite via its devshell
[group('test')]
test app *args:
    #!/usr/bin/env bash
    cd ../{{app}}
    rm -rf tmp/cache/bootsnap 2>/dev/null || true
    nix-shell ../scint-to-nix/tests/{{app}}/devshell.nix \
        --run "RAILS_ENV=test bundle exec rails test {{args}}"

# Run lint suite
[group('test')]
lint app="fizzy":
    tests/lint/run-all {{app}}

# Verify all generated nix files pass nixfmt
[group('test')]
fmt-check:
    find nix/ -name '*.nix' | xargs nixfmt --check
