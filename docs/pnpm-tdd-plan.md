# pnpm Support Plan (TDD)

## Goals

- Add first-class `pnpm` support to `onix` with the same workflow shape:
  - `onix import`
  - `onix generate`
  - `onix build`
- Target **workspace roots only** for the first version.
- Deliver near-instant project startup by prebuilding a materialized `node_modules` tree in Nix and hydrating it into the workspace.
- Support private registries without storing secrets in generated files.

## Fixed Decisions

- Workspace scope: `roots only` (no per-importer builds yet).
- Hydration mode: `copy/rsync only` (no symlink mode, due to ESM/tooling compatibility).
- Scripts policy:
  - default `allowed` (respect `onlyBuiltDependencies` / `ignoredBuiltDependencies` from `pnpm-workspace.yaml`)
  - fallback to `ignore-scripts` when no allowlist policy is present
  - CLI override: `--scripts=none|allowed`
- pnpm version policy:
  - pin to lockfile/project `packageManager` major when present
  - fail if lockfile major is newer than the selected pnpm major
- CLI shape:
  - keep existing commands
  - auto-detect lockfile type in `onix import`
  - explicit override remains available: `--installer pnpm`

## Consolidated Progress

- [x] Import snapshot-key helper for canonical peer/key variants (`lib/onix/pnpm/lockfile.rb`).
- [x] Deterministic package ordering and stable non-semver fallback in node generation (`lib/onix/commands/generate.rb`).
- [x] Real node derivation in `lib/onix/data/build-node-modules.nix` with offline install path and preserved `.pnpm` layout.
- [x] Deterministic build output path capture via `--out-link` (`lib/onix/commands/build.rb`).
- [x] Copy/rsync hydration + `.node_modules_id` fast-path (`lib/onix/commands/build.rb`).
- [x] Runtime credential resolver and secret masking tests (`lib/onix/pnpm/credentials.rb`, `test/pnpm_credentials_test.rb`).
- [x] Script-policy default/override flow in import and generate (`lib/onix/pnpm/project_config.rb`, `lib/onix/commands/generate.rb`).
- [x] Deterministic `fetchPnpmDeps` hash strategy (`lib/onix/commands/generate.rb`), including probe-and-parse output hash and environment token injection.
- [x] Vite pilot validation and startup latency measurements.
- [x] Tighten script policy surface to `none|allowed` for `onix generate --scripts` input.
- [x] End-to-end validation rerun after hardening updates (2026-02-18):
  - `nix develop ... ruby exe/onix check` => `3 passed · 0 failed`
  - `rake test` => `58 runs, 243 assertions, 0 failures`
- [x] Nonstandard pnpm lockfile-name support hardening (2026-02-18):
  - prefetch expression now normalizes `<project>.pnpm-lock.yaml` to `pnpm-lock.yaml` for `fetchPnpmDeps`
  - `build-node-modules.nix` normalizes lockfile naming for both prefetch and install phases
  - coverage added in `test/generate_node_test.rb`
- [x] Lockfile discovery drift fix via persisted metadata (2026-02-18):
  - import now stores `_meta.lockfile_path` for both ruby and pnpm imports
  - generate prefers `_meta.lockfile_path` before heuristic lockfile candidates
  - docs updated: `docs/packageset-format.md`
  - coverage added in `test/pnpm_importer_test.rb` and `test/generate_node_test.rb`
- [x] Deterministic packageset serialization ordering (2026-02-18):
  - `Packageset.write` now sorts by installer/name/version/source/path for stable duplicate-name output
  - regression coverage added in `test/packageset_test.rb`
- [x] Cross-host lockfile portability (`lockfile_relpath`) (2026-02-18):
  - `_meta.lockfile_relpath` added alongside `_meta.lockfile_path`
  - import persists repo-relative lockfile path when lockfile is inside project root
  - generate prefers `lockfile_relpath` first, then absolute path, then heuristics
  - docs updated and regression coverage added
- [x] Legacy metadata backfill + portability warning (2026-02-18):
  - added `onix backfill` to populate `lockfile_path`/`lockfile_relpath` for existing packagesets
  - `onix check` now includes `packageset-metadata` warning when `lockfile_relpath` is missing
  - regression coverage added in `test/backfill_test.rb` and `test/check_node_test.rb`

## Engineering Principles

- Separation of concerns first:
  - `onix import`: parse lockfiles, normalize graph shape, write packagesets
  - `onix generate`: materialize deterministic Nix expressions only
  - `onix build`: run derivations, produce artifacts, expose hydration helpers
  - shared parsing/type logic stays in `lib/onix/pnpm/*`
- KISS (keep it simple):
  - prefer one straightforward path over feature-complete edge-handling in phase 1
  - keep workspace-root behavior as the explicit baseline until later expansion
  - avoid hidden defaults; keep command flags visible and explicit
- DRY without over-abstracting:
  - share helper functions for lockfile parsing, package-entry normalization, and deterministic keying
  - only abstract when repeated behavior appears in two or more commands, not preemptively
- Systems-thinking:
  - design around end-to-end startup story: import → generate → build → dev shell hydration
  - treat lockfile parsing, package graph, and runtime behavior as one causal chain with guardrails at each boundary
  - design private-credential handling as a cross-cutting system property (no leakage from parse through generate through build artifacts)

## Non-Goals (Phase 1)

- Per-importer install outputs.
- Hoisted linker mode parity with every pnpm edge case.
- Cross-platform binary reproducibility across mismatched target platforms.
- Full `yarn`/`npm` support.

## Architecture

- Runtime baseline while building pnpm support:
  - `nix develop` is wired to a deterministic Ruby + `nodejs` + `pnpm` toolchain via `flake.nix`.
  - Keep dev shell tooling focused on phase-1 scope and reproducible workflows.

### Import

Input files:
- `pnpm-lock.yaml` (required)
- `pnpm-workspace.yaml` (required for workspace mode)
- `package.json` (root metadata: `packageManager`, engines)

Output:
- `packagesets/<project>.jsonl` with `installer: "node"` entries.

Captured data:
- lockfile version
- importers (root/workspace projects)
- package snapshots and dependency edges
- `resolution` (integrity, tarball/git/directory where present)
- `optional`, `os`, `cpu`, `libc`, `engines`
- peer-variant dep paths (suffix forms)
- `link:` / `file:` references

### Generate

- Emit node-specific Nix artifacts (parallel to Ruby outputs), initially:
  - `nix/node/<project>.nix`
  - `nix/build-node-modules.nix`
  - `nix/node-config.nix`
- Use nixpkgs `fetchPnpmDeps` + `pnpmConfigHook` primitives for store prefetch + offline install.
- Produce derivation outputs containing a pre-materialized `node_modules` tree for workspace root hydration.

### Build

- `onix build <project>` builds node modules derivation(s).
- Build output includes:
  - node_modules payload
  - identity/sentinel metadata used to detect hydration staleness.

### Dev Hydration

- Dev shell hook copies from built store path to workspace `node_modules` using `rsync --delete`.
- Track last hydrated store path in `.node_modules_id`.
- If store path unchanged, skip hydration.

## Private Registry Support

Requirements:
- Never write auth tokens into:
  - `packagesets/*.jsonl`
  - `nix/**/*.nix`
  - logs
- Resolve credentials at runtime from:
  - env vars (`NPM_TOKEN`, host-scoped forms)
  - `.npmrc` (project/user)
  - netrc if applicable

Implementation outline:
- Add a credentials resolver for npm registries (parallel to current Ruby credentials handling).
- Normalize registry host mapping and token lookup.
- Pass auth only as ephemeral environment/config during fetch/install phases.
- Ensure generated nix remains credential-free.

## TDD Strategy

Test framework:
- Add Minitest-based suite (`test/`) for fast unit + golden tests.
- Keep heavy integration tests opt-in via env flags.

Use pnpm tests as inspiration from:
- `pkg-manager/headless/test/fixtures/*/pnpm-lock.yaml`
- `lockfile/fs/test/fixtures/*`
- peer-variant examples and `depPathToFilename` behavior.

### Test Layers

1. Unit: lockfile parsing
- lockfile v9 parsing (`importers`, `packages`, `snapshots`)
- `link:`/`file:` handling
- peer suffix dep paths preserved
- optional/platform constraints captured

2. Unit: importer behavior
- auto-detect pnpm project
- root-only scope enforcement
- metadata extraction from `packageManager`

3. Unit: generator rendering
- generated nix includes expected attrs and no credentials
- deterministic output ordering

4. Integration: offline materialization
- fixture project builds `node_modules` derivation
- hydration hook copies files into workspace
- second run is fast no-op when sentinel unchanged

5. Integration: private registry (stubbed)
- token resolution from env + `.npmrc`
- credentials not present in output files
- failures show actionable errors without leaking secrets
- completed 2026-02-18:
  - `onix build` now redacts `_authToken` and `Authorization: Bearer` values in console output tail
  - node build failures with auth indicators (`E401` / `ERR_PNPM_FETCH_401` / unauthorized) emit an actionable credential hint
  - coverage added in `test/build_node_test.rb`, including direct `print_tail` stderr redaction assertions

## Phased Task Plan

### Phase Exit Checklist (applies to every phase)

- Separation of concerns:
  - No command exceeds a single responsibility.
  - Data parsing, model shaping, and file emission are in different methods/modules.
- KISS:
  - New behavior is no more complex than the phase requirement.
  - No speculative support flags or unrequested compatibility modes.
- DRY:
  - Repeated logic is extracted only when it appears in at least two phases/commands.
  - New helpers have one clear owner and explicit call sites.
- Systems thinking:
  - If a phase changes shape, import/generate/build semantics remain coherent end-to-end.
  - Changes include no secret-path regression (packageset, generated nix, logs, build outputs).

## Phase 0: Test Harness

- [x] Add `test/` harness with Minitest runner.
- [x] Add fixture loader utilities.
- [x] Import minimal pnpm fixtures (simple/workspace/peer variants).
- [x] Add CI/local command: `rake test`.

Acceptance:
- Tests run green in repo before pnpm feature tests are added.

## Phase 1: Import (Red → Green)

- [x] Write failing tests for pnpm lock parsing and packageset serialization.
- [x] Implement `onix import` pnpm detection + parser path.
- [x] Extend packageset docs and metadata for node installer entries.
- [x] Keep Ruby import behavior unchanged.
- [x] Run and pass phase-1 checklist (separation/KISS/DRY/systems checks).

Acceptance:
- pnpm importer tests green.
- Ruby importer regression tests green.
- Exit checklist:
  - [x] Separation of concerns verified.
  - [x] KISS constraints respected.
  - [x] DRY opportunities justified or intentionally deferred.
  - [x] Systems flow and secret-surface checks passed.

### Phase 1 Runbook (execution)
- [x] Added/updated import-path tests (`test/pnpm_importer_test.rb`) covering:
  - ruby lockfile auto-detect
  - pnpm lockfile auto-detect
  - workspace root validation
  - root importer success path
- [x] Added lockfile parser tests (`test/pnpm_lockfile_parse_test.rb`) covering:
  - v9 header parse
  - `link:` dependency capture
  - peer suffix key preservation
- [x] Full `onix` command execution under Ruby >= 3.1 (validated in `nix develop` pilot run on 2026-02-18).

## Phase 2: Generate (Red → Green)

- [x] Write failing golden tests for generated node nix files.
- [x] Implement node generator and support templates.
- [x] Deterministic, sorted rendering.
- [x] Update `onix check` completeness logic for node installer.

Acceptance:
- Golden tests green.
- Existing Ruby generation tests/flows unaffected.
- Exit checklist:
  - [x] Separation of concerns verified.
  - [x] KISS constraints respected.
  - [x] DRY opportunities justified or intentionally deferred.
  - [x] Systems flow and secret-surface checks passed.

## Phase 3: Build + Hydration (Red → Green)

- [x] Write failing integration test for materialized node_modules output.
- [x] Implement build target(s) and dev hydration hook.
- [x] Ensure copy/rsync-only behavior (no symlink mode).
- [x] Add sentinel ID optimization.

Acceptance:
- First hydrate populates `node_modules`.
- Second hydrate is no-op when unchanged.
- Exit checklist:
  - [x] Separation of concerns verified.
  - [x] KISS constraints respected.
  - [x] DRY opportunities justified or intentionally deferred.
  - [x] Systems flow and secret-surface checks passed.
- [x] Deterministic `fetchPnpmDeps` hash strategy (probe + output parsing).

## Phase 4: Private Registries (Red → Green)

- [x] Write failing tests for credential resolution order and masking.
- [x] Implement npm credential resolver.
- [x] Thread credentials into fetch/install phases only.
- [x] Add secret scan checks for generated artifacts.

Acceptance:
- Private registry tests green.
- No credentials in generated files or logs.
- Exit checklist:
- [x] Separation of concerns verified.
- [x] KISS constraints respected.
- [x] DRY opportunities justified or intentionally deferred.
- [x] Systems flow and secret-surface checks passed.

## Phase 5: Vite Pilot + Hardening

- [x] Add a runnable Vite pilot runbook in this plan, including expected outputs and failure diagnosis.
- [x] Add script-backed benchmark workflow for baseline and no-op hydrate timing (`scripts/pilot-pnpm-onix.sh`).
- [x] Finalize docs in README and `docs/packageset-format.md` for launch.
- [x] Execute pilot in `/Users/vsumner/src/github.com/vitejs/vite` and capture first/second-run data.
- [x] Confirm no credentials/log leaks from pilot run and document remediation.

Acceptance:
- Vite workspace can be hydrated from onix-built output.
- Repeat hydration/build is materially faster than fresh install path.
- `.node_modules_id` skips unnecessary copies when upstream node_modules output hash is unchanged.
- Pilot execution does not write secrets to git-tracked artifacts.
- Exit checklist:
  - [x] Separation of concerns verified.
  - [x] KISS constraints respected.
  - [x] DRY opportunities justified or intentionally deferred.
  - [x] Systems flow and secret-surface checks passed.

## Pilot Results (2026-02-18)

- Command: `scripts/pilot-pnpm-onix.sh /Users/vsumner/src/github.com/vitejs/vite`
- Generate duration: `79s`
- First `onix build vite` (hydrate): `45s` (+ `~2.1s` cached eval+`~42.9s` pnpm install phase in this run)
- Second `onix build vite` (no-op hydration): `23s`
- First/second sentinel id:
  - `sha256-qQ8wy5NcZCL++bICwOU5vDDGuJ1amy8oq57sMEFWJ8Y=/vite/allowed`
- No-op confirmation: second pass logged `node_modules unchanged`.
- Hydrated size snapshot: `2.3G node_modules`.
- Secret scan (textual grep in project root): no credential matches tied to secrets; only `npm`/`token` strings in lockfile/package metadata remain.

## Phase 5 Runbook (actualized)

- **Pilot path**: `/Users/vsumner/src/github.com/vitejs/vite` (or configured `$ONIX_PILOT_PATH`)
- **Project name default**: `vite` (folder name unless `--name` used)
- **Prereqs**:
  - `onix` from current checkout.
  - `nix`, `pnpm`, `rg`, `rsync` available.
  - Git checkout for the pilot project.

### Step 0 — readiness checks

1. Ensure pilot exists:
   - `test -d "$ONIX_PILOT_PATH"` and `test -f "$ONIX_PILOT_PATH/pnpm-lock.yaml"`
2. Ensure the path is clean for timing:
   - `git -C "$ONIX_PILOT_PATH" status --short` (capture as baseline)
3. Ensure no stale artifact from earlier runs:
   - `test ! -f "$ONIX_PILOT_PATH/.node_modules_id"`
   - `test ! -d "$ONIX_PILOT_PATH/node_modules"`

### Step 1 — import/generate/build

1. `cd "$ONIX_PILOT_PATH"`
2. `onix import .`
3. `onix generate`
4. `onix build vite` (or pass `vite` explicitly as project name)

Expected:
- `packagesets/vite.jsonl` exists and contains `_meta.package_manager` and `_meta.script_policy`.
- `nix/node/vite.nix` and `nix/build-node-modules.nix` exist.
- `onix build` emits a node derivation build path and hydrate message.

### Step 2 — first-hydrate benchmark

1. Remove workspace output:
   - `rm -rf node_modules .node_modules_id`
2. `time onix build vite`
3. Capture:
   - wall time
   - `du -sh node_modules`
   - path marker:
     - `cat .node_modules_id`

Expected:
- `node_modules` exists with both `node_modules` and `node_modules/.pnpm`.
- `cat .node_modules_id` points to a `/nix/store/...-onix-vite-node-modules` path.

### Step 3 — no-op hydration pass

1. Re-run `time onix build vite` without deleting artifacts.
2. Validate guard:
   - output includes `node_modules unchanged` or no rsync copy.
   - `.node_modules_id` hash/path unchanged between passes.

Expected:
- elapsed build time for second pass is materially shorter than first pass.
- no large rsync transfer if unchanged.

### Step 4 — failure drills

- Missing lockfile:
  - remove `pnpm-lock.yaml`, rerun `onix import` and expect clear lockfile error.
- No credentials:
  - unset all relevant token env vars and clear `.npmrc`, rerun build in private-registry-dependent dependency path; expect actionable message.
- Secret leak check:
  - `rg -n "npm|token|_authToken|auth" packagesets/*.jsonl nix/*` should return no secrets.
  - verify log output if build fails: avoid posting raw token values.
- Path drift:
  - if `projectRoot`/`lockfile` in generated file differs from expected path, compare import root and regenerate.

### Step 5 — capture command recipe (single line)

- `ONIX_PILOT_PATH=/Users/vsumner/src/github.com/vitejs/vite \
  scripts/pilot-pnpm-onix.sh`

This prints a compact markdown-ish section with timestamps, durations, and `.node_modules_id` deltas.

### Notes

- The pilot validates the full chain: import → generate → build → hydrated node_modules.
- Copy/rsync mode is mandatory for ESM compatibility; symlink mode is intentionally not used in phase-1.
- If pilot data indicates slow first-run times, focus on `nix-build` cache health and upstream lockfile drift before changing onix behavior.

## Phase 6: Node Overlay + Codegen Parity (Planned)

Intent:
- Move pnpm support from lifecycle-script policy control toward onix-native build behavior encoded in generated Nix and explicit overlays.

Scope:
- Keep workspace-root phase-1 scope.
- Keep copy/rsync hydration only (no symlink mode).
- Keep private-registry behavior ephemeral and non-persistent.

Tasks:
- [x] Tighten script policy surface:
  - [x] deprecate/remove `--scripts=all`
  - [x] keep `none|allowed` only
  - [x] preserve default `allowed`, fallback `none`
- [x] Define node overlay contract (parallel to Ruby overlays):
  - location: `overlays/node/<package>.nix`
  - support deps/build tools/env/hooks for known script-heavy/native packages
  - implemented loader in `lib/onix/data/node-config.nix` and wired via generator
- [x] Add node overlay wiring integration test:
  - coverage in `test/generate_node_test.rb` for `overlays/node/<package>.nix` pass-through to generated Nix
- [x] Add node codegen inference in `onix generate`:
  - infer known build deps/flags from lock/package metadata where deterministic
  - emit inferred requirements directly in generated Nix when possible
  - reserve overlays for non-inferable cases
- [x] Add node hardening checks in `onix check`:
  - node completeness and render-validity checks
  - node secret-surface checks over `packagesets/**`, `nix/**`, and logs
- [x] Add integration tests:
- [x] script policy behavior (`none` vs `allowed`) without `all` (`test/generate_node_test.rb`)
- [x] legacy metadata `script_policy: "all"` is rejected with actionable error (`SystemExit`) (`test/generate_node_test.rb`)
- [x] overlay application path for one fixture package (`test/generate_node_test.rb`)
  - [x] no-op second hydration assertion with stable sentinel (`test/build_node_test.rb`)

Acceptance:
- Node builds for known script-heavy/native packages are handled by generated Nix + overlay contract, not broad lifecycle-script enablement.
- Script policy surface is reduced to `none|allowed`.
- Node checks fail fast with actionable errors when overlay/codegen support is missing.
- Private-registry credentials remain absent from persisted artifacts.

Phase 6 Exit Checklist:
- [x] Separation of concerns verified.
- [x] KISS constraints respected.
- [x] DRY opportunities justified or intentionally deferred.
- [x] Systems flow and secret-surface checks passed.

## Definition of Done

- pnpm workflow works end-to-end for workspace root projects.
- TDD cycle followed for each phase (tests authored first).
- private registry flows supported without credential leakage.
- existing Ruby workflow remains backward compatible.
