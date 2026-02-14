# frozen_string_literal: true

module Onix
  module CLI
    COMMANDS = {
      "init"        => "Initialize a new project",
      "import"      => "Import Gemfile.lock into a hermetic packageset",
      "import-pnpm" => "Import pnpm-lock.yaml into a hermetic packageset",
      "generate"    => "Prefetch hashes and generate nix derivations",
      "build"       => "Build all packages via Nix",
      "check"       => "Run checks on built packages",
    }.freeze

    def self.run(argv)
      if argv.empty? || (argv.first&.start_with?("-") && !COMMANDS.key?(argv.first))
        if argv.include?("--version") || argv.include?("-v")
          puts "onix #{VERSION}"
          return
        end
        usage
        exit(argv.include?("--help") || argv.include?("-h") ? 0 : 1)
      end

      command = argv.shift
      unless COMMANDS.key?(command)
        $stderr.puts "Unknown command: #{command}"
        $stderr.puts
        usage
        exit 1
      end

      file = command.tr("-", "_")
      const = file.split("_").map(&:capitalize).join
      require_relative "commands/#{file}"
      klass = Onix::Commands.const_get(const)
      klass.new.run(argv)
    end

    def self.usage
      $stderr.puts
      $stderr.puts UI.bold("onix") + " #{UI.dim(VERSION)}"
      $stderr.puts UI.dim("  Nix-packaged dependencies")
      $stderr.puts
      COMMANDS.each do |name, desc|
        $stderr.puts "  #{UI.amber(name.ljust(13))} #{desc}"
      end
      $stderr.puts
      $stderr.puts UI.dim("  Ruby:  init → import → generate → build")
      $stderr.puts UI.dim("  Node:  init → import-pnpm → generate → build")
      $stderr.puts
    end
  end
end
