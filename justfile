set shell := ["bash", "-e", "-u", "-o", "pipefail", "-c"]

# --- Core workflow ----------------------------------------------------------
# Default target: show the available commands.
default: help

help:
  @echo 'Onix project tasks'
  @echo ''
  @echo 'Common:'
  @echo '  just init'
  @echo '  just import . [name]'
  @echo '  just import-pnpm .'
  @echo '  just generate jobs=20 scripts=none'
  @echo '  just build [project] [target]'
  @echo '  just hydrate project [target]'
  @echo '  just test [paths...]'
  @echo '  just check'
  @echo '  just backfill'
  @echo '  just pilot .'
  @echo ''
  @echo '  just workflow .    # full bootstrap: init -> import -> generate -> check -> build'
  @echo '  just ci                  # run checks, tests, and a full rebuild'

alias t := test
alias c := check

alias b := build
alias i := import
alias g := generate

# --- Bootstrap and generation ------------------------------------------------
[group: 'bootstrap']
init:
  just _onix init

_onix *args:
  if [ -x "{{justfile_directory()}}/exe/onix" ] && [ -d "{{justfile_directory()}}/../scint/lib" ]; then ruby -I"{{justfile_directory()}}/lib" -I"{{justfile_directory()}}/../scint/lib" "{{justfile_directory()}}/exe/onix" {{args}}; elif [ -x "{{justfile_directory()}}/exe/onix" ]; then ruby -I"{{justfile_directory()}}/lib" "{{justfile_directory()}}/exe/onix" {{args}}; elif command -v onix >/dev/null; then onix {{args}}; else echo "required command missing: onix"; exit 1; fi

import project="." name="":
  if [ "{{name}}" = "" ]; then just _onix import "{{project}}"; else just _onix import --name "{{name}}" "{{project}}"; fi

import-pnpm project=".":
  just _onix import --installer pnpm "{{project}}"

[group: 'generate']
generate jobs="20" scripts="none":
  just _onix generate -j {{jobs}} --scripts {{scripts}}

generate-quick:
  just _onix generate --scripts none

backfill:
  just _onix backfill

[group: 'build']
build project="" target="":
  if [ -z "{{project}}" ]; then just _onix build; elif [ -z "{{target}}" ]; then just _onix build "{{project}}"; else just _onix build "{{project}}" "{{target}}"; fi

# Build one project's node_modules only.
build-node project:
  just _onix build "{{project}}" node

# Hydrate one project's node_modules into a target workspace.
hydrate project target="":
  if [ -z "{{target}}" ]; then just _onix hydrate "{{project}}"; else just _onix hydrate --target "{{target}}" "{{project}}"; fi

[group: 'quality']
check checks="":
  if [ -z "{{checks}}" ]; then just _onix check; else just _onix check {{checks}}; fi

fmt-nix:
  files="$(git ls-files '*.nix')"; \
  if [ -n "$files" ]; then nixfmt $files; fi

fmt-check:
  files="$(git ls-files '*.nix')"; \
  if [ -n "$files" ]; then nixfmt --check $files; fi

test *paths:
  ruby -Ilib -Itest -e 'Dir["test/**/*_test.rb"].sort.each { |f| load f }'

test-paths *paths:
  ruby -Ilib -Itest {{paths}}

test-file path:
  just test-paths "{{path}}"

check-secrets:
  just _onix check secrets

check-metadata:
  just _onix check packageset-metadata

qa:
  just fmt-check
  just check
  just test

# --- Helpers ----------------------------------------------------------------
[group: 'workflow']
workflow project=".":
  just import "{{project}}"
  just generate
  just check
  just build

ci project=".":
  just workflow "{{project}}"
  just test

pilot project=".":
  scripts/pilot-pnpm-onix.sh "{{project}}"

# Local environment and preflight checks
[group: 'environment']
dev-shell:
  nix --extra-experimental-features nix-command --extra-experimental-features flakes develop

deps:
  [ -x "{{justfile_directory()}}/exe/onix" ] || [ -x "{{justfile_directory()}}/../exe/onix" ] || ( echo "required command missing: onix"; exit 1 )
  command -v rsync >/dev/null || ( echo "required command missing: rsync"; exit 1 )
  command -v rg >/dev/null || ( echo "required command missing: rg"; exit 1 )
  command -v git >/dev/null || ( echo "required command missing: git"; exit 1 )
  command -v nix >/dev/null || ( echo "required command missing: nix"; exit 1 )
  command -v ruby >/dev/null || ( echo "required command missing: ruby"; exit 1 )

clean:
  rm -rf node_modules .node_modules_id .onix_node_modules_id
