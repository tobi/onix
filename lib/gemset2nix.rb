# frozen_string_literal: true

require "json"
require "fileutils"

require_relative "gemset2nix/version"
require_relative "gemset2nix/ui"
require_relative "gemset2nix/project"
require_relative "gemset2nix/extconf_scanner"
require_relative "gemset2nix/nix_writer"
require_relative "gemset2nix/nix_template"
require_relative "gemset2nix/cli"

module Gemset2Nix
end
