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
{"_meta":true,"ruby":"3.4.8","bundler":"2.6.5","platforms":["arm64-darwin","ruby"]}
```

**Line 2+: one entry per package**
```json
{"installer":"ruby","name":"rack","version":"3.1.12","source":"rubygems","remote":"https://rubygems.org","deps":["webrick"]}
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

## Node source types

### `npm` — from an npm registry

```json
{"installer":"node","name":"express","version":"4.21.2","source":"npm","remote":"https://registry.npmjs.org","deps":{"body-parser":"1.20.3","cookie":"0.7.1"}}
```

| Field | Required | Description |
|-------|----------|-------------|
| `remote` | yes | npm registry URL |
| `deps` | no | Versioned dependencies `{name: version}` (from pnpm snapshots) |
| `bin` | no | Executable mappings `{"cli": "./bin/cli.js"}` |
| `has_native` | no | Has node-gyp / NAPI native addon |
| `os` | no | Platform OS constraints `["darwin", "linux"]` |
| `cpu` | no | Platform CPU constraints `["x64", "arm64"]` |
| `libc` | no | Platform libc constraints `["glibc", "musl"]` |

### `git` — from a git repository (node)

```json
{"installer":"node","name":"my-pkg","version":"1.0.0","source":"git","uri":"https://github.com/org/repo.git","rev":"abc123..."}
```

Same fields as Ruby git source (`uri`, `rev`, `branch`, `tag`, `subdir`, `submodules`).

## The `installer` field

Every entry has an `installer` field: `"ruby"` or `"node"`. This identifies
which build system handles the package. The generate step uses it to select
the right builder (`build-gem.nix` for Ruby, `build-npm.nix` for Node).

### Key difference: `deps` format

- **Ruby:** `deps` is an array of names: `["racc", "mini_portile2"]`
- **Node:** `deps` is a hash of name→version: `{"body-parser": "1.20.3", "cookie": "0.7.1"}`

Node deps include versions because pnpm supports multiple versions of the
same package. The versioned dep graph is used to create the `.pnpm/` virtual
store layout with correctly targeted symlinks.

## Node metadata line

```json
{"_meta":true,"pnpm":"9.0","platforms":["arm64-darwin","x64-linux"]}
```

The `node` and `pnpm` fields replace `ruby` and `bundler` in the metadata line.

## Design principles

1. **Hermetic**: the packageset + overlays are sufficient to reproduce the
   build. No external lookups needed after import.

2. **Import does the hard work**: cloning git repos to discover subdirectories,
   resolving platform variants, classifying stdlib gems. Everything after
   import is mechanical.

3. **Human-readable**: JSONL is easy to diff, grep, and inspect. One line per
   package means clean git diffs when versions change.
