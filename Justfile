# gemset2nix — Justfile

set shell := ["bash", "-euo", "pipefail", "-c"]

ruby := "ruby_3_4"

# ── Build ──────────────────────────────────────────────────────────

# Build gems: all, by app, or a single gem
[group('build')]
build *args:
    RUBY={{ruby}} ruby -Ilib exe/gemset2nix build {{args}}

# ── Generate ───────────────────────────────────────────────────────

# Fetch all gem sources into cache/
[group('generate')]
fetch *args:
    ruby -Ilib exe/gemset2nix fetch {{args}}

# Regenerate all gem derivations + selectors from cache
[group('generate')]
update:
    ruby -Ilib exe/gemset2nix update

# Import a project (name or path to Gemfile.lock)
[group('generate')]
import *args:
    ruby -Ilib exe/gemset2nix import {{args}}

# Initialize a new project
[group('generate')]
init *args:
    ruby -Ilib exe/gemset2nix init {{args}}

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
        if [[ -d "$target" ]]; then
            rm -f "$link"
            ln -s "$(cd "$target" && pwd)" "$link"
            n=$((n + 1))
        fi
    done
    echo "Linked $n source directories."

# ── Test & Lint ────────────────────────────────────────────────────

# Run lint suite
[group('test')]
lint app="fizzy":
    tests/lint/run-all {{app}}

# Run an app's test suite
[group('test')]
test app:
    tests/{{app}}/run-tests

# Run all app tests
[group('test')]
test-all:
    tests/run-all
