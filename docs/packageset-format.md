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

## The `installer` field

Every entry has `"installer":"ruby"`. This identifies which build system
handles the package. Future ecosystem support:

```json
{"installer":"node","name":"esbuild","version":"0.21.5","source":"npm","remote":"https://registry.npmjs.org/"}
```

The generate step dispatches on `installer` to select the right builder
(`build-gem.nix` for Ruby, `build-npm.nix` for Node, etc.).

## Design principles

1. **Hermetic**: the packageset + overlays are sufficient to reproduce the
   build. No external lookups needed after import.

2. **Import does the hard work**: cloning git repos to discover subdirectories,
   resolving platform variants, classifying stdlib gems. Everything after
   import is mechanical.

3. **Human-readable**: JSONL is easy to diff, grep, and inspect. One line per
   package means clean git diffs when versions change.

4. **Ecosystem-agnostic**: the `installer` field makes the format extensible
   to npm, pip, cargo, etc. without changing the structure.
