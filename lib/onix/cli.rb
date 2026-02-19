# frozen_string_literal: true

module Onix
  module CLI
    COMMANDS = {
      "init"     => "Initialize a new project",
      "import"   => "Import Gemfile.lock into a hermetic packageset",
      "generate" => "Prefetch hashes and generate nix derivations",
      "build"    => "Build all gems via Nix",
      "hydrate"  => "Hydrate node_modules into a target workspace",
      "check"    => "Run checks on built gems",
      "backfill" => "Backfill packageset metadata fields",
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

      require_relative "commands/#{command}"
      klass = Onix::Commands.const_get(command.capitalize)
      klass.new.run(argv)
    end

    def self.usage
      $stderr.puts
      $stderr.puts UI.bold("onix") + " #{UI.dim(VERSION)}"
      $stderr.puts UI.dim("  Nix-packaged Ruby gems")
      $stderr.puts
      COMMANDS.each do |name, desc|
        $stderr.puts "  #{UI.amber(name.ljust(10))} #{desc}"
      end
      $stderr.puts
      $stderr.puts UI.dim("  Workflow: init → import → generate → build → hydrate")
      $stderr.puts
    end
  end
end
