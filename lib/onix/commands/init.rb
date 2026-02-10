# frozen_string_literal: true

module Onix
  module Commands
    class Init
      def run(argv)
        while argv.first&.start_with?("-")
          case argv.shift
          when "--help", "-h"
            $stderr.puts "Usage: onix init [directory]"
            exit 0
          end
        end

        root = File.expand_path(argv.shift || ".")
        name = File.basename(root)

        dirs = %w[packagesets overlays nix/ruby]
        created = 0

        dirs.each do |d|
          path = File.join(root, d)
          unless Dir.exist?(path)
            FileUtils.mkdir_p(path)
            created += 1
          end
        end

        readme_path = File.join(root, "README.md")
        unless File.exist?(readme_path)
          File.write(readme_path, readme(name))
          UI.wrote "README.md"
          created += 1
        end

        if created == 0
          UI.skip "Already initialized"
        else
          $stderr.puts
          $stderr.puts "  #{UI.bold(name)}/ ready. Next steps:"
          $stderr.puts
          $stderr.puts "  #{UI.amber("1.")} onix import path/to/Gemfile.lock"
          $stderr.puts "  #{UI.amber("2.")} onix generate"
          $stderr.puts "  #{UI.amber("3.")} onix build"
          $stderr.puts
        end
      end

      private

      def readme(name)
        <<~MD
          # #{name}

          Nix-packaged Ruby gems, managed by [onix](https://github.com/tobi/onix).

          ## Quick start

          ```bash
          onix import path/to/project     # parse Gemfile.lock → packagesets/project.jsonl
          onix generate                    # prefetch hashes → nix/ruby/*.nix + nix/project.nix
          onix build project               # build all gems via nix
          ```

          ## Directory structure

          ```
          #{name}/
          ├── packagesets/     # Hermetic JSONL packagesets (one per project)
          ├── overlays/        # Hand-written build overrides
          └── nix/             # ⚠ Generated — never edit by hand
              ├── ruby/        # Per-gem version files (rack.nix, nokogiri.nix, ...)
              ├── project.nix  # Per-project gem selection
              ├── build-gem.nix    # Generic builder
              └── gem-config.nix   # Overlay loader
          ```

          ## Overlays

          When a gem needs system libraries or custom build steps, create
          `overlays/<gem-name>.nix`:

          ```nix
          # overlays/pg.nix — simplest case: just add deps
          { pkgs, ruby }: with pkgs; [ libpq pkg-config ]

          # overlays/nokogiri.nix — deps + flags
          { pkgs, ruby }: {
            deps = with pkgs; [ libxml2 libxslt pkg-config zlib ];
            extconfFlags = "--use-system-libraries";
          }
          ```

          See `docs/overlays.md` and `docs/packageset-format.md` for details.
        MD
      end
    end
  end
end
