# frozen_string_literal: true

module Gemset2Nix
  module Commands
    class Init
      def run(argv)
        while argv.first&.start_with?("-")
          case argv.shift
          when "--help", "-h"
            $stderr.puts "Usage: gemset2nix init [directory]"
            $stderr.puts
            $stderr.puts "Initialize a new gemset2nix project in the given directory (default: .)"
            exit 0
          end
        end

        root = File.expand_path(argv.shift || ".")
        name = File.basename(root)

        files = {
          "cache/sources/"        => :dir,
          "cache/meta/"           => :dir,
          "cache/gems/"           => :dir,
          "cache/git-clones/"     => :dir,
          "nix/gem/"              => :dir,
          "nix/app/"              => :dir,
          "nix/modules/"          => :dir,
          "overlays/"             => :dir,
          "gemsets/"              => :dir,
          "cache/.gitignore"      => "gems/\ngit-clones/\n",
          "nix/modules/resolve.nix" => File.read(File.expand_path("../../data/resolve.nix", __dir__)),
          "nix/modules/apps.nix"    => "{\n}\n",
          "README.md"               => readme(name),
        }

        created = 0
        files.each do |rel, content|
          path = File.join(root, rel)
          if content == :dir
            unless Dir.exist?(path)
              FileUtils.mkdir_p(path)
              created += 1
            end
          else
            unless File.exist?(path)
              FileUtils.mkdir_p(File.dirname(path))
              File.write(path, content)
              UI.wrote rel
              created += 1
            end
          end
        end

        if created == 0
          UI.skip "Already initialized"
        else
          $stderr.puts
          $stderr.puts "  #{UI.bold(name)}/ ready. Next steps:"
          $stderr.puts
          $stderr.puts "  #{UI.amber("1.")} gemset2nix import path/to/Gemfile.lock"
          $stderr.puts "  #{UI.amber("2.")} gemset2nix fetch"
          $stderr.puts "  #{UI.amber("3.")} gemset2nix generate"
          $stderr.puts "  #{UI.amber("4.")} gemset2nix build"
          $stderr.puts
        end
      end

      def readme(name)
        <<~MD
          # #{name}

          Nix-packaged Ruby gems, managed by [gemset2nix](https://github.com/tobi/gemset2nix).

          ## Quick start

          ```bash
          # 1. Import gems from a Gemfile.lock
          gemset2nix import path/to/project

          # 2. Fetch all gem sources into cache/
          gemset2nix fetch

          # 3. Generate Nix derivations from cached sources
          gemset2nix generate

          # 4. Build everything
          gemset2nix build

          # 5. Check for problems (runs automatically after generate)
          gemset2nix check
          ```

          ## Workflow

          ### Import

          Copy a `Gemfile.lock` into the project as a gemset:

          ```bash
          gemset2nix import ~/src/myapp               # reads myapp/Gemfile.lock
          gemset2nix import --name myapp Gemfile.lock  # explicit path + name
          ```

          Gemset files are copies of `Gemfile.lock` stored in `gemsets/`.
          Scint's lockfile parser reads them — standard Bundler format.

          ### Fetch

          Download gem sources into `cache/`. Rubygems are fetched and unpacked;
          git repos are cloned and checked out at the pinned revision:

          ```bash
          gemset2nix fetch           # fetch everything in gemsets/
          gemset2nix fetch -j8       # parallel (default: 20)
          ```

          ### Update

          Generate Nix derivations from the cached sources and metadata:

          ```bash
          gemset2nix generate
          ```

          This creates:
          - `nix/gem/<name>/<version>/default.nix` — one derivation per gem
          - `nix/gem/<name>/default.nix` — version selector
          - `nix/modules/gem.nix` — catalogue of all gems

          ### Build

          Build all gem derivations via Nix:

          ```bash
          gemset2nix build                  # build every gem in the pool
          gemset2nix build myapp            # build all gems for one app
          gemset2nix build myapp nokogiri   # build a specific gem from an app
          gemset2nix build --gem nokogiri   # build a gem by name (latest version)
          ```

          ### Check

          Run checks on generated derivations:

          ```bash
          gemset2nix check                       # all checks
          gemset2nix check symlinks nix-eval     # specific checks
          ```

          Checks: `symlinks`, `nix-eval`, `source-clean`, `secrets`,
          `dep-completeness`, `require-paths-vs-metadata`.

          ---

          ## Overlays

          Most gems build automatically. When a gem needs system libraries or custom
          build steps, create an overlay in `overlays/<gem-name>.nix`. Overlays are
          hand-maintained — generators never touch them.

          ### Auto-detection

          `gemset2nix generate` scans each gem's `ext/**/extconf.rb` and automatically
          detects common native dependencies (`pkg_config`, `find_library`,
          `have_header` calls). It also detects Rust gems that use `rb_sys`.
          Auto-detected deps are inlined directly into the generated derivation —
          no overlay needed for straightforward cases.

          **Manual overlays always win over auto-detection.** If an overlay exists
          for a gem, the auto-detected deps are ignored entirely.

          ### Simplest overlay: system library deps

          If a gem's `extconf.rb` needs a system library that wasn't auto-detected:

          ```nix
          # overlays/pg.nix
          { pkgs, ruby }: with pkgs; [ libpq pkg-config ]
          ```

          The return value is a list added to `nativeBuildInputs`. The default build
          phase (`ruby extconf.rb && make`) runs automatically.

          ### Overlay with extconf flags

          Some gems bundle their own copy of a library but support a flag to use the
          system version instead. **Always use system libraries** — never link against
          vendored copies:

          ```nix
          # overlays/sqlite3.nix
          { pkgs, ruby }: {
            deps = with pkgs; [ sqlite pkg-config ];
            extconfFlags = "--enable-system-libraries";
          }
          ```

          `extconfFlags` is appended to every `ruby extconf.rb` call.

          ### Build-time gem dependencies

          Some gems require other gems at build time (e.g., `nokogiri` needs
          `mini_portile2` during `extconf.rb`). Use `buildGems` to declare them
          as derivations — the framework constructs `GEM_PATH` automatically:

          ```nix
          # overlays/nokogiri.nix
          { pkgs, ruby }: {
            deps = with pkgs; [ libxml2 libxslt pkg-config zlib ];
            extconfFlags = "--use-system-libraries";
            buildGems = [
              (pkgs.callPackage ../nix/gem/mini_portile2/2.8.9 { inherit ruby; })
            ];
          }
          ```

          Each `buildGems` entry must be a derivation with a `bundle_path`
          passthru attribute (i.e., built by `gemset2nix generate`).

          ### Lifecycle hooks

          Hooks let you run shell commands at specific points without replacing the
          entire build:

          ```nix
          # overlays/charlock_holmes.nix
          { pkgs, ruby }: {
            deps = with pkgs; [ icu zlib pkg-config which ];
            beforeBuild = ''
              export CXXFLAGS="$CXXFLAGS -std=c++17"
            '';
          }
          ```

          ### Rust gems

          Gems using Rust via `rb_sys` are auto-detected. If the auto-detection
          misses one, write an overlay:

          ```nix
          # overlays/tiktoken_ruby.nix
          { pkgs, ruby }: {
            deps = with pkgs; [ rustc cargo libclang ];
            buildGems = [
              (pkgs.callPackage ../nix/gem/rb_sys/0.9.124 { inherit ruby; })
            ];
            beforeBuild = ''
              export CARGO_HOME="$TMPDIR/cargo"
              mkdir -p "$CARGO_HOME"
              export LIBCLANG_PATH="${pkgs.libclang.lib}/lib"
            '';
          }
          ```

          ### Full custom build

          When the default `extconf.rb` + `make` flow won't work at all,
          replace it entirely:

          ```nix
          # overlays/libv8-node.nix
          { pkgs, ruby }: {
            deps = with pkgs; [ nodejs_22 python3 ];
            buildPhase = ''
              mkdir -p vendor/v8
              ln -s ${pkgs.nodejs_22.libv8}/lib vendor/v8/lib
              ln -s ${pkgs.nodejs_22.libv8}/include vendor/v8/include
            '';
          }
          ```

          ### Skip a gem entirely

          Some gems are incompatible with the current Ruby version or abandoned:

          ```nix
          # overlays/therubyracer.nix — abandoned, use mini_racer
          { pkgs, ruby }: {
            buildPhase = "true";  # no-op
          }
          ```

          ### Overlay contract reference

          An overlay is a function `{ pkgs, ruby }:` returning one of:

          | Return type | Meaning |
          |-------------|---------|
          | `[ dep1 dep2 ]` | Extra `nativeBuildInputs`, default build phase |
          | `{ ... }` | Attrset with options (see below) |

          **Attrset fields:**

          | Field | Type | Description |
          |-------|------|-------------|
          | `deps` | list | Extra `nativeBuildInputs` |
          | `extconfFlags` | string | Appended to every `ruby extconf.rb` call |
          | `buildGems` | list | Derivations needed at build time (auto `GEM_PATH`) |
          | `beforeBuild` | string | Shell commands before the default build phase |
          | `afterBuild` | string | Shell commands after the default build phase |
          | `buildPhase` | string | **Replaces** the entire default build phase |
          | `postInstall` | string | Shell commands at end of install (`$dest` is set) |

          **Default build phase** (when `buildPhase` is not set):
          ```bash
          for extconf in $(find ext -name extconf.rb); do
            dir=$(dirname "$extconf")
            (cd "$dir" && ruby extconf.rb $extconfFlags && make -j$NIX_BUILD_CORES)
          done
          # copies built .so files from ext/ to lib/
          ```

          ---

          ## Directory structure

          ```
          #{name}/
          ├── gemsets/          # Gemfile.lock copies (one per project)
          ├── overlays/         # Hand-written build overrides
          ├── cache/
          │   ├── sources/      # Unpacked gem source trees
          │   ├── meta/         # Gem metadata (JSON)
          │   ├── gems/         # Downloaded .gem files
          │   └── git-clones/   # Bare git clones
          └── nix/              # ⚠ Generated — never edit by hand
              ├── gem/          # Per-gem derivations + version selectors
              ├── app/          # Per-project gem lists
              └── modules/      # Catalogue, resolver, app registry
          ```

          Everything under `nix/` is generated. Run `gemset2nix generate` to regenerate.

          ## Design

          - **Everything local.** No network access during Nix builds. `fetch` downloads
            all sources ahead of time; derivations use `builtins.path` (local paths only).
          - **System libraries only.** Native gems always link against nixpkgs libraries,
            never vendored copies. This is the whole point of hermetic builds.
          - **Gemfile.lock is the source of truth.** Gemset files are unmodified copies
            of `Gemfile.lock`, parsed by Scint's lockfile parser.
          - **Auto-detect where possible, overlay where not.** `extconf.rb` analysis
            inlines common deps automatically. Overlays handle everything else.
          - **Manual overlays always win** over auto-detection.
        MD
      end

      # resolve.nix lives in lib/gemset2nix/data/resolve.nix — single source of truth
    end
  end
end
