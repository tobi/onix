# gemset2nix — Justfile

set shell := ["bash", "-euo", "pipefail", "-c"]

ruby := "ruby_3_4"

# ── Build ──────────────────────────────────────────────────────────

# Build gems: all, by app, or a single gem
[group('build')]
build app="" gem="":
    RUBY={{ruby}} bin/build {{app}} {{gem}}

# Build across ruby versions
[group('build')]
matrix app="" rubyver="":
    #!/usr/bin/env bash
    set -euo pipefail
    if [[ -n "{{rubyver}}" ]]; then
        attr="{{rubyver}}"
        [[ -n "{{app}}" ]] && attr="${attr}.{{app}}"
        echo "Building matrix: $attr..."
        nix-build nix/matrix.nix --no-out-link --keep-going -A "$attr"
    elif [[ -n "{{app}}" ]]; then
        echo "Building {{app}} across all rubies..."
        rubies=$(nix-instantiate --eval -E 'builtins.attrNames (import ./nix/matrix.nix {})' 2>/dev/null | tr -d '[]"' | tr ' ' '\n' | grep -v '^$')
        for r in $rubies; do
            echo "  $r.{{app}}..."
            nix-build nix/matrix.nix --no-out-link --keep-going -A "$r.{{app}}" 2>&1 | tail -1
        done
    else
        echo "Building full matrix..."
        nix-build nix/matrix.nix --no-out-link --keep-going
    fi

# ── Generate ───────────────────────────────────────────────────────

# Fetch all gem sources into cache/
[group('generate')]
fetch:
    bin/fetch imports/

# Regenerate all gem derivations + selectors from cache
[group('generate')]
generate:
    bin/generate

# Import a project (name or path to Gemfile.lock)
[group('generate')]
import *args:
    bin/import {{args}}

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

# ── Test & Lint ────────────────────────────────────────────────────

# Run lint suite (10 checks)
[group('test')]
lint app="fizzy":
    tests/lint/run-all {{app}}

# Run an app's test suite
[group('test')]
test app:
    tests/{{app}}/run-tests
