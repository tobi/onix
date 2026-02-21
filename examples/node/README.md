# Node Examples

Curated Node scenarios that model Onix intent: globally reusable dependency artifacts plus project-scoped composition.

These examples are source fixtures. Run them in an isolated temp directory so generated `nix/` and `packagesets/` stay out of this repository.

## Scenario Matrix

| State | Scenario | Purpose |
|---|---|---|
| Basic single importer | `scenarios/basic-single` | Baseline import/generate/build/hydrate path |
| Workspace multi-importer graph | `scenarios/workspace-multi-importer` | Ensures all importers are captured |
| Nonstandard lockfile name | `scenarios/nonstandard-lockfile` | Validates `*.pnpm-lock.yaml` handling |
| Overlay canonical contract | `scenarios/overlay-canonical` | Uses `deps/preBuild/postBuild/buildPhase/postInstall/installFlags` |
| Overlay migration error | `scenarios/overlay-migration-error` | Demonstrates deprecated Node keys fail fast |
| Hydrate fast path | `scenarios/basic-single` | Build/hydrate once, then no-op hydrate |
| Hydrate invalidation | `scenarios/overlay-canonical` | Overlay drift forces rehydrate |
| Optional `pnpm install` flow | `scenarios/basic-single` | Hydrate-first still supports manual pnpm install |

## Quick Runner Pattern

```bash
REPO=/path/to/onix
SCENARIO=basic-single
WORKDIR=$(mktemp -d)

cp -R "$REPO/examples/node/scenarios/$SCENARIO/." "$WORKDIR/"
cd "$WORKDIR"

onix init
onix import --installer pnpm --name app .
onix generate
```

Use project name `app` for `onix build` and `onix hydrate` commands.

## 1) Basic Single Importer

```bash
REPO=/path/to/onix
WORKDIR=$(mktemp -d)
cp -R "$REPO/examples/node/scenarios/basic-single/." "$WORKDIR/"

cd "$WORKDIR"
onix init
onix import --installer pnpm --name app .
onix generate
onix build app node
onix hydrate app .
```

## 2) Workspace Multi-Importer

```bash
REPO=/path/to/onix
WORKDIR=$(mktemp -d)
cp -R "$REPO/examples/node/scenarios/workspace-multi-importer/." "$WORKDIR/"

cd "$WORKDIR"
onix init
onix import --installer pnpm --name app .
onix generate
onix build app node
onix hydrate app .
```

Inspect `packagesets/app.jsonl` and confirm entries include importer data for both `bar` and `foo`.

## 3) Nonstandard Lockfile Name

```bash
REPO=/path/to/onix
WORKDIR=$(mktemp -d)
cp -R "$REPO/examples/node/scenarios/nonstandard-lockfile/." "$WORKDIR/"

cd "$WORKDIR"
onix init
onix import --installer pnpm --name app workspace.pnpm-lock.yaml
onix generate
onix build app node
onix hydrate app .
```

## 4) Overlay Canonical Contract

```bash
REPO=/path/to/onix
WORKDIR=$(mktemp -d)
cp -R "$REPO/examples/node/scenarios/overlay-canonical/." "$WORKDIR/"

cd "$WORKDIR"
onix init
onix import --installer pnpm --name app .
onix generate
onix build app node
onix hydrate app .
```

## 5) Overlay Migration Error (Expected Failure)

```bash
REPO=/path/to/onix
WORKDIR=$(mktemp -d)
cp -R "$REPO/examples/node/scenarios/overlay-migration-error/." "$WORKDIR/"

cd "$WORKDIR"
onix init
onix import --installer pnpm --name app .
onix generate
onix build app node
```

Expected: fail-fast error from `node-config.nix` for deprecated keys like `preInstall` and `pnpmInstallFlags`.

## 6) Hydrate Fast Path

```bash
# continue from a successful basic-single run
onix build app node
onix hydrate app .

onix build app node
onix hydrate app .
```

Expected: second hydrate reports unchanged marker and skips copying.

## 7) Hydrate Invalidation On Overlay Drift

```bash
# start from overlay-canonical scenario
onix build app node
onix hydrate app .

# mutate overlay to change overlay digest
printf '\n# drift marker\n' >> overlays/node/is-positive.nix

onix generate
onix build app node
onix hydrate app .
```

Expected: marker identity changes and hydrate is not skipped.

## 8) Optional `pnpm install` After Hydrate

```bash
# continue from any successful hydrate run
pnpm install
pnpm run build
pnpm run dev
```

Expected: manual pnpm path remains functional.
