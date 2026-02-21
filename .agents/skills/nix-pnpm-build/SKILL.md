---
name: nix-pnpm-build
description: Fix failing Node/pnpm Nix builds and hydration by adjusting import/generate/build inputs and Node overlays. Use when `onix build <project> node` or `onix hydrate <project>` fails, or when cache reuse/identity behavior is wrong.
---

# Fixing Node/pnpm Build And Hydrate Failures

Use this skill for the Node path only:

```bash
onix import --installer pnpm <path-or-lockfile>
onix generate
onix build <project> node
onix hydrate <project> [target]
```

Do not use this for Ruby gem extension failures. Use `/nix-ruby-build` for those.

## Architecture Intent (Node)

1. Import lockfile graph into `packagesets/<project>.jsonl` (including workspace importers).
2. Generate per-package Node metadata into `nix/node/<name>.nix` and per-project wiring into `nix/<project>.nix`.
3. Build a globally reusable dependency artifact keyed by lockfile hash + node major + pnpm major + target system.
4. Compose project-scoped `node_modules` from that artifact.
5. Hydrate into workspace and skip only when full marker identity matches.

## Fast Triage

1. Identify failing phase: `import`, `generate`, `build node`, or `hydrate`.
2. Read failing drv logs when in build phase:

```bash
nix log /nix/store/<...>.drv
```

3. Confirm generated inputs are consistent:

```bash
rg -n "globalDepsKey|nodeVersionMajor|pnpmVersionMajor|workspacePaths" nix/<project>.nix
rg -n "artifactIdentity|overlayDigest|workspaceDigest|.node_modules_id" nix/build-node-modules.nix
```

## Failure Patterns

| Signal | Likely Cause | Fix |
|---|---|---|
| `Unable to resolve pnpm lockfile hash` | Prefetch hash failed (lockfile/project mismatch, invalid lockfile context, registry/auth issue) | Confirm lockfile path and root, refresh lockfile, verify auth/env, rerun generate |
| `Node overlay <name>.nix uses deprecated key(s)` | Old Node overlay contract keys used | Migrate keys (see overlay contract below) |
| `Unsupported script policy "all"` | Invalid script policy | Use only `none` or `allowed` |
| `ERR_PNPM_FETCH_401` / auth errors | Missing registry auth in build sandbox | Set `NPM_TOKEN` or scoped token lines; verify `.npmrc` strategy |
| `noBrokenSymlinks` workspace links | Workspace importer paths not represented in project composition | Re-import from workspace root, regenerate; confirm importer/workspace paths are present |
| Hydrate skips when it should not | Marker identity too stale or not regenerated | Regenerate/build first; inspect `.node_modules_id` and `.onix_node_modules_id`; run hydrate with `--force` |

## Node Overlay Contract

Node overlays live in `overlays/node/<package>.nix` and must return a list or attrset.

Canonical keys:

- `deps`
- `preBuild`
- `postBuild`
- `buildPhase`
- `postInstall`
- `installFlags`

Deprecated keys (fail fast):

- `preInstall`
- `prePnpmInstall`
- `pnpmInstallFlags`

Minimal examples:

```nix
{ pkgs }:
with pkgs;
[ python3 ]
```

```nix
{ pkgs }:
{
  deps = [ pkgs.python3 ];
  preBuild = ''
    echo "prepare" >&2
  '';
  installFlags = [ "--link-workspace-packages=false" ];
}
```

## Identity And Reuse Rules

Node dependency reuse is scoped by:

- lockfile content hash (`pnpmDepsHash`)
- `pnpm` major
- `node` major
- target system

Hydration marker identity also includes:

- script policy
- overlay digest
- workspace path digest

Debug marker values:

```bash
cat /nix/store/<...>-onix-<project>-node-modules-0/.node_modules_id
cat <target>/.onix_node_modules_id
```

If values differ, hydrate should copy. If equal, hydrate should skip.

## Workspaces And Importers

For workspaces, import from the workspace root so all importers are captured.

```bash
onix import --installer pnpm --name <project> .
```

For nonstandard lockfile names:

```bash
onix import --installer pnpm --name <project> workspace.pnpm-lock.yaml
```

Verify importer metadata exists:

```bash
rg -n '"installer":"node"' packagesets/<project>.jsonl
rg -n '"importer":' packagesets/<project>.jsonl
```

## Build/Hydrate Loop

```bash
onix generate
onix build <project> node
onix hydrate <project> [target]
```

Rehydrate force path:

```bash
onix hydrate --force <project> [target]
```

Optional pnpm path after hydrate is valid:

```bash
pnpm install
pnpm run build
pnpm run dev
```

## Verification Checklist

1. `onix check` passes.
2. `onix build <project> node` succeeds.
3. First hydrate copies `node_modules` and writes `.onix_node_modules_id`.
4. Second hydrate is a no-op when identity is unchanged.
5. Overlay or workspace drift changes marker identity and forces copy.
6. `pnpm run build` and `pnpm run dev` work after hydrate.

## When To Escalate To Code Changes

If repeated failures require manual workaround each run, fix generators/templates instead of patching per-project state:

- `lib/onix/commands/import.rb`
- `lib/onix/commands/generate.rb`
- `lib/onix/data/build-node-modules.nix`
- `lib/onix/data/node-config.nix`

Do not hand-edit generated files in `nix/`; regenerate with `onix generate`.
