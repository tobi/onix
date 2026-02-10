# frozen_string_literal: true

require "optparse"

module Gemset2Nix
  module CLI
    COMMANDS = {
      "init"   => "Initialize a new gemset2nix project",
      "import" => "Import gems from a Gemfile.lock",
      "fetch"  => "Fetch gem sources into cache/",
      "update" => "Regenerate all Nix derivations from cache",
      "build"  => "Build gem derivations via Nix",
    }.freeze

    def self.run(argv)
      if argv.empty? || argv.first.start_with?("-")
        if argv.include?("--version") || argv.include?("-v")
          puts "gemset2nix #{VERSION}"
          return
        end
        usage
        return
      end

      command = argv.shift
      unless COMMANDS.key?(command)
        $stderr.puts "Unknown command: #{command}"
        $stderr.puts
        usage
        exit 1
      end

      require_relative "commands/#{command}"
      klass = Gemset2Nix::Commands.const_get(command.capitalize)
      klass.new.run(argv)
    end

    def self.usage
      $stderr.puts "Usage: gemset2nix <command> [options]"
      $stderr.puts
      $stderr.puts "Commands:"
      COMMANDS.each do |name, desc|
        $stderr.puts "  %-10s %s" % [name, desc]
      end
      $stderr.puts
      $stderr.puts "Run 'gemset2nix <command> --help' for details."
    end
  end
end
