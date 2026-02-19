# Packageset Format

A packageset is a JSONL file (one JSON object per line) that describes every
package needed for a project. It's the single source of truth for hermetic
builds — everything downstream is mechanical.

## File structure

```
packagesets/<project>.jsonl
```

**Line 1: metadata**
```json
{"_meta":true,"ruby":"3.4.8","bundler":"2.6.5","platforms":["arm64-darwin","ruby"],"package_manager":"pnpm@10.0.0","script_policy":"none","lockfile_path":"/abs/path/to/pnpm-lock.yaml"}
```

**Line 2+: one entry per package**
```json
{"installer":"ruby","name":"rack","version":"3.1.12","source":"rubygems","remote":"https://rubygems.org","deps":["webrick"]}
{"installer":"node","name":"rimraf","version":"2.7.1","source":"pnpm","deps":["glob"]}
```

## Source types

### `rubygems` — from a gem server

```json
{"installer":"ruby","name":"nokogiri","version":"1.19.0","source":"rubygems","remote":"https://rubygems.org","deps":["racc","mini_portile2"],"has_ext":true}
```

| Field | Required | Description |
|-------|----------|-------------|
| `remote` | yes | Gem server URL |
| `deps` | no | Runtime dependency names |
| `require_paths` | no | Default: `["lib"]` |
| `executables` | no | Bin stubs to create |
| `has_ext` | no | Has native extensions (triggers platform aliases) |
| `groups` | no | Default: `["default"]` |

### `git` — from a git repository

```json
{"installer":"ruby","name":"activesupport","version":"8.0.0","source":"git","uri":"https://github.com/rails/rails.git","rev":"60d92e4e7dfe...","branch":"main","subdir":"activesupport","deps":["i18n","tzinfo"]}
```

| Field | Required | Description |
|-------|----------|-------------|
| `uri` | yes | Git clone URL |
| `rev` | yes | Full commit SHA (the only thing used for fetch) |
| `branch` | no | Informational — not used for builds |
| `tag` | no | Informational — not used for builds |
| `subdir` | no | Subdirectory within repo (monorepo support). Omitted = root. |
| `submodules` | no | Fetch git submodules? Default: false |
| `deps` | no | Runtime dependency names |

### `path` — local directory

```json
{"installer":"ruby","name":"my-gem","version":"0.1.0","source":"path","path":"vendor/my-gem"}
```

Path sources are local development gems. They're included in the packageset
for completeness but skipped during nix generation.

### `stdlib` — shipped with Ruby

```json
{"installer":"ruby","name":"json","version":"2.9.1","source":"stdlib"}
```

Stdlib gems are built into the Ruby binary. They're skipped during nix
generation — Ruby already provides them.

### `pnpm` — from a pnpm lockfile

```json
{"installer":"node","name":"rimraf","version":"2.7.1","source":"pnpm","deps":["glob"]}
```

| Field | Required | Description |
|-------|----------|-------------|
| `deps` | no | Runtime dependency names |
| `groups` | no | Dependency scope defaults to `default` |
| `path` | no | Used for `link:` / `file:` dependencies |
| `source` | no | One of `pnpm`, `link`, `file` |
| `version` | yes | Raw value from lockfile, including peer suffixes when present (e.g. `1.0.0(peer@2.0.0)`) |
`_meta` can also include:

| Field | Required | Description |
|-------|----------|-------------|
| `package_manager` | no | e.g. `pnpm@10.0.0` from `package.json` |
| `script_policy` | no | One of `none` (default) or `allowed` (workspace allowlist present / explicit `--scripts allowed`) |
| `lockfile_path` | no | Absolute lockfile path captured at import; used by `generate` to avoid lockfile discovery drift |

### Node-specific notes

- `installer: "node"` entries are consumed by the generated `nix/build-node-modules.nix` pipeline.
- `version` values are preserved verbatim for deterministic peer-suffix keying.
- `source: "link"` / `source: "file"` entries carry lockfile path targets in `path`.
- `script_policy` is applied in generated node install phase as either `--ignore-scripts` (`none`) or default pnpm behavior (`allowed`).
- Node-specific overrides can be provided as `overlays/node/<package>.nix` and are loaded through
  `nix/node-config.nix`. Overlay contracts are deterministic and do not receive secret inputs.

## The `installer` field

Each entry uses one of these values:

- `"ruby"` — handled by `build-gem.nix` in the Ruby pipeline.
- `"node"` — handled by node derivations introduced for pnpm.

`generate` selects the right builder from this field.

## Design principles

1. **Hermetic**: the packageset + overlays are sufficient to reproduce the
   build. No external lookups needed after import.

2. **Import does the hard work**: cloning git repos to discover subdirectories,
   resolving platform variants, classifying stdlib gems. Everything after
   import is mechanical.

3. **Human-readable**: JSONL is easy to diff, grep, and inspect. One line per
   package means clean git diffs when versions change.
