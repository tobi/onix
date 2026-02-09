# AGENTS.md

## Philosophy

Solve problems through better codegen. When a gem fails to load, build, or link — fix the generator (`bin/generate`) to emit better `.nix` files. Don't patch individual gem derivations by hand. Every fix should flow through the codegen so that a clean `rm -rf out/gems && bin/generate` reproduces the correct output.

## Bundler-compatible BUNDLE_PATH layout

The devshell must produce a `BUNDLE_PATH` directory that `require "bundler/setup"` accepts without modification. This means the nix `bundle-path.nix` output must match the exact structure bundler expects.

### What `bundler/setup` does

1. Reads `Gemfile.lock` to discover all gems and their sources.
2. For **rubygems sources**: finds gems via `Gem::Specification` search in `BUNDLE_PATH/specifications/*.gemspec`. The gem dirs live at `BUNDLE_PATH/gems/<name>-<version>/`.
3. For **git sources**: looks at `Bundler.install_path` = `BUNDLE_PATH/bundler/gems/`. Each git repo is a directory named `<base_name>-<shortref>` where:
   - `base_name` = `File.basename(uri.sub(%r{^(\w+://)?([^/:]+:)?(//\w*/)?(\w*/)*}, ""), ".git")`
   - `shortref` = first 12 chars of the revision SHA
4. Git gem specs are loaded from `.gemspec` files found by globbing `{,*,*/*}.gemspec` inside the checkout directory. Monorepos like rails have nested gemspecs (e.g. `activesupport/activesupport.gemspec`).
5. Calls `spec.activate` on each gem → adds `require_paths` to `$LOAD_PATH`.
6. Then `Bundler.require(*Rails.groups)` auto-requires gems by group.

### Required BUNDLE_PATH structure

```
BUNDLE_PATH/
  gems/                                    # rubygems-sourced gems
    rack-3.2.4/
    concurrent-ruby-1.3.6/
    ...
  specifications/                          # rubygems gemspecs (with add_dependency)
    rack-3.2.4.gemspec
    concurrent-ruby-1.3.6.gemspec
    ...
  bundler/
    gems/                                  # git-sourced gem checkouts
      rails-60d92e4e7dfe/                  # rails monorepo (contains nested gemspecs)
        activesupport/
          activesupport.gemspec
          lib/
        actionpack/
          actionpack.gemspec
          lib/
        ...
        rails.gemspec
      lexxy-4f0fc4d5773b/                  # single-gem git repo
        lexxy.gemspec
        lib/
      useragent-433ca320a42d/              # single-gem git repo
        useragent.gemspec (or *.gemspec)
        lib/
```

### Git sources from fizzy's Gemfile.lock

| Remote | base_name | Revision | shortref | Gems |
|--------|-----------|----------|----------|------|
| `https://github.com/rails/rails.git` | `rails` | `60d92e4e7dfe...` | `60d92e4e7dfe` | actioncable, actionmailbox, actionmailer, actionpack, actiontext, actionview, activejob, activemodel, activerecord, activestorage, activesupport, rails, railties (13 gems) |
| `https://github.com/basecamp/lexxy` | `lexxy` | `4f0fc4d5773b...` | `4f0fc4d5773b` | lexxy |
| `https://github.com/basecamp/useragent` | `useragent` | `433ca320a42d...` | `433ca320a42d` | useragent |

### Key insight

Git-sourced gems must NOT go in `gems/` + `specifications/`. They must go in `bundler/gems/<base>-<shortref>/` with their real `.gemspec` files. Bundler resolves them through a completely different code path (`Bundler::Source::Git` → `load_spec_files` → globs for `*.gemspec` in the checkout dir).

Rubygems-sourced gems go in `gems/` + `specifications/` as before.

### What `bin/generate` must do

1. Parse git sources from `Gemfile.lock` (remote, revision, which gems come from each).
2. For **rubygems gems**: generate per-gem `default.nix` as now, outputting into `gems/` + `specifications/`.
3. For **git gems**: generate a checkout-style directory at `bundler/gems/<base>-<shortref>/` containing the full source tree with real `.gemspec` files intact. For monorepos (rails), the whole repo is one checkout with nested subdirectories.
4. `bundle-path.nix` must assemble both layouts into the final store path.

### `requires_checkout?` gate

Bundler only tries to `git fetch`/`checkout` when `requires_checkout?` returns true:

```ruby
def requires_checkout?
  allow_git_ops? && !local? && !cached_revision_checked_out?
end

def cached_revision_checked_out?
  cached_revision && cached_revision == revision && install_path.exist?
end
```

If `install_path.exist?` is true AND `cached_revision` matches the lockfile revision, no git operations happen. The revision comes from `options["revision"]` which is set when parsing Gemfile.lock. So we just need the directory to exist at the right path.

## Current issues

- **Git source layout**: `bundle-path.nix` currently puts all gems (including git-sourced) into flat `gems/` + `specifications/`. This breaks `bundler/setup` which expects git gems at `bundler/gems/<base>-<shortref>/`. Fix: separate git gems into their own layout in the nix output.
- **`require_paths`**: The spec.marshal files are written by a different Ruby version (3.4.7) than the nix Ruby (3.3.9), so `Marshal.load` fails. Fixed: fall back to parsing `.gem` YAML metadata.
- **Native extensions**: Pre-built `.so` from scint's cache are stripped and recompiled inside the Nix sandbox. The `compile.nix` override hook exists for gems that need manual build tuning.
- **Gemspec dependencies**: Stub gemspecs now include `add_dependency` entries so RubyGems can activate the full dependency chain at runtime.

## Rules

1. `default.nix` per gem is always overwritten by `bin/generate` — never hand-edit.
2. `compile.nix` per gem is never overwritten — manual build overrides go here.
3. If a gem breaks, figure out why and fix the generator to handle that class of problem.
4. Test with `bin/test-bundle`, `tests/lint/run-all`, and `nix-shell tests/fizzy/devshell.nix`.
