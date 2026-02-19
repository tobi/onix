#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ONIX_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
DEFAULT_PROJECT_DIR="${ONIX_PILOT_PATH:-$(pwd)}"
PROJECT_DIR="${1:-$DEFAULT_PROJECT_DIR}"
PROJECT_NAME="${2:-$(basename "$PROJECT_DIR")}"
REPORT_FILE="${ONIX_PILOT_REPORT:-${PROJECT_DIR}/.onix-pilot-report.md}"
declare -a ONIX_CMD=()

log() {
  echo "$*"
}

require_ruby_for_onix() {
  local ruby_bin="${ONIX_RUBY:-ruby}"
  local version
  version="$(${ruby_bin} -e 'print RUBY_VERSION')"
  local major minor
  IFS="." read -r major minor _ <<< "$version"

  if [ "$major" -lt 3 ] || { [ "$major" -eq 3 ] && [ "$minor" -lt 1 ]; }; then
    log "onix CLI execution requires Ruby >= 3.1, but current ruby is $version."
    log "Run from the onix dev shell, for example:"
    log "  cd \"$ONIX_ROOT\""
    log "  nix --extra-experimental-features nix-command --extra-experimental-features flakes develop \\"
    log "    --command scripts/pilot-pnpm-onix.sh <project-dir>"
    exit 1
  fi
}

run_step() {
  local name="$1"
  shift

  log ""
  log "### $name"
  local start end elapsed
  start=$(date +%s)
  local status=0
  if ! "$@"; then
    status=$?
  fi
  end=$(date +%s)
  elapsed=$((end - start))
  log "  duration: ${elapsed}s (exit ${status})"
  return "$status"
}

require_cmd() {
  local cmd=$1
  if ! command -v "$cmd" >/dev/null 2>&1; then
    log "required command missing: $cmd"
    exit 1
  fi
}

run_onix() {
  local cmd=("${ONIX_CMD[@]}")
  "${cmd[@]}" "$@"
}

run_onix_project() {
  (cd "$PROJECT_DIR" && run_onix "$@")
}

resolve_onix_cmd() {
  local local_exe="$SCRIPT_DIR/../exe/onix"
  local local_lib="$SCRIPT_DIR/../lib"
  local onix_ruby="${ONIX_RUBY:-ruby}"
  local local_scint="${ONIX_SCINT_LIB:-$(dirname "$SCRIPT_DIR")/../scint/lib}"

  if command -v onix >/dev/null 2>&1; then
    ONIX_CMD=(onix)
    return
  fi

  if [ -x "$local_exe" ]; then
    if [ -d "$local_scint" ]; then
      ONIX_CMD=("$onix_ruby" -I "$local_lib" -I "$local_scint" "$local_exe")
    else
      ONIX_CMD=("$onix_ruby" -I "$local_lib" "$local_exe")
    fi
    return
  fi

  log "required command missing: onix"
  exit 1
}

node_id() {
  local p="$PROJECT_DIR/.onix_node_modules_id"
  if [ -f "$p" ]; then
    cat "$p"
  else
    echo "<missing>"
  fi
}

cd "$PROJECT_DIR"

log "# Onix pnpm pilot"
log ""
log "- project: $PROJECT_DIR"
log "- project name: $PROJECT_NAME"
log "- report: $REPORT_FILE"
log ""

require_cmd nix
require_cmd git
require_cmd rg
require_cmd rsync

require_ruby_for_onix
resolve_onix_cmd

if [ ! -f pnpm-lock.yaml ]; then
  log "missing pnpm-lock.yaml in $PROJECT_DIR"
  exit 1
fi

run_step "Readiness: lockfile" bash -lc "test -f pnpm-lock.yaml"
run_step "Readiness: git status capture" bash -lc "git -C \"$PROJECT_DIR\" status --short"

run_step "Import" run_onix_project import .
run_step "Generate" run_onix_project generate

run_step "Pre-clean" bash -lc "cd \"$PROJECT_DIR\" && rm -rf node_modules .onix_node_modules_id .node_modules_id"
ID_BEFORE="$(node_id)"
log "- prior .onix_node_modules_id: $ID_BEFORE"

run_step "Build node derivation (first run)" run_onix_project build "$PROJECT_NAME" node
run_step "Hydrate node_modules (first run)" run_onix_project hydrate "$PROJECT_NAME" "$PROJECT_DIR"
ID_AFTER_FIRST="$(node_id)"
log "- post-first-run .onix_node_modules_id: $ID_AFTER_FIRST"

if [ ! -d "$PROJECT_DIR/node_modules" ]; then
  log "node_modules not present after first run"
  exit 1
fi

if [ ! -d "$PROJECT_DIR/node_modules/.pnpm" ]; then
  log "node_modules/.pnpm missing after first run"
  exit 1
fi

run_step "Build node derivation (second run)" run_onix_project build "$PROJECT_NAME" node
run_step "Hydrate node_modules (second run)" run_onix_project hydrate "$PROJECT_NAME" "$PROJECT_DIR"
ID_AFTER_SECOND="$(node_id)"
log "- post-second-run .onix_node_modules_id: $ID_AFTER_SECOND"

if [ "$ID_AFTER_FIRST" = "$ID_AFTER_SECOND" ]; then
  log "- node_modules id unchanged: no-op path hit"
else
  log "- node_modules id changed: re-hydrated from changed derivation"
fi

run_step "Node module size snapshot" bash -lc "cd \"$PROJECT_DIR\" && du -sh node_modules"
run_step "Secret surface scan" bash -lc "cd \"$PROJECT_DIR\" && \
  rg -n \"npm.*token|_auth|authToken|Authorization|Bearer\" --glob '!node_modules' --glob '!.git' . 2>/dev/null || true"

cat > "$REPORT_FILE" <<EOF
# Onix pnpm pilot report

- project: $PROJECT_DIR
- project_name: $PROJECT_NAME
- date: $(date -u +%Y-%m-%dT%H:%M:%SZ)
- first_id: $ID_AFTER_FIRST
- second_id: $ID_AFTER_SECOND
- unchanged: $([ "$ID_AFTER_FIRST" = "$ID_AFTER_SECOND" ] && echo "true" || echo "false")
EOF

log ""
log "report written: $REPORT_FILE"
log "phase-1 pilot completed"
