# frozen_string_literal: true

require "uri"
require "cgi"

module Onix
  # Reads .npmrc files for registry auth tokens.
  # Used by generate to authenticate nix-prefetch-url against private registries.
  #
  # .npmrc format:
  #   @myorg:registry=https://npm.example.com/
  #   //npm.example.com/:_authToken=${NPM_TOKEN}
  #
  class Npmrc
    def initialize
      @tokens = {}     # "host/path" => token
      @registries = {} # "@scope" => "https://registry.url/"
      load_npmrc_files
    end

    # Get the registry URL for a scoped package, or nil for default.
    def registry_for(package_name)
      return nil unless package_name.start_with?("@")
      scope = package_name.split("/").first
      @registries[scope]
    end

    # Inject auth token into a URL for nix-prefetch-url.
    # Returns the URL with embedded credentials, or the original URL if no token.
    def inject_auth(url)
      token = token_for(url)
      return url unless token

      parsed = URI.parse(url)
      # nix-prefetch-url supports HTTP Basic auth in the URL
      parsed.user = "_token"
      parsed.password = CGI.escape(token)
      parsed.to_s
    rescue URI::InvalidURIError
      url
    end

    private

    def token_for(url)
      parsed = URI.parse(url) rescue nil
      return nil unless parsed

      # Try progressively shorter paths: host/path/to/registry → host/path → host
      host_path = "#{parsed.host}#{parsed.path}"
      segments = host_path.split("/").reject(&:empty?)

      segments.length.downto(1) do |n|
        key = segments[0...n].join("/")
        return @tokens[key] if @tokens.key?(key)
        # Also try with trailing slash
        return @tokens["#{key}/"] if @tokens.key?("#{key}/")
      end
      nil
    end

    def load_npmrc_files
      files = []

      # User config: ~/.npmrc
      user_config = ENV["NPM_CONFIG_USERCONFIG"] || File.join(Dir.home, ".npmrc")
      files << user_config if File.exist?(user_config)

      # Project config: ./.npmrc
      project_config = File.join(Dir.pwd, ".npmrc")
      files << project_config if File.exist?(project_config)

      files.each { |f| parse_npmrc(File.read(f)) }
    end

    def parse_npmrc(content)
      content.each_line do |raw_line|
        line = raw_line.strip
        next if line.empty? || line.start_with?("#") || line.start_with?(";")

        idx = line.index("=")
        next unless idx

        key = line[0...idx].strip
        value = expand_env(line[(idx + 1)..].strip)

        # Scope registry: @myorg:registry=https://npm.example.com/
        if key.end_with?(":registry") && key.start_with?("@")
          scope = key[0...key.index(":registry")]
          @registries[scope] = value.chomp("/")
        end

        # Auth token: //npm.example.com/:_authToken=xxx
        if key.start_with?("//") && key.include?(":_authToken")
          host_path = key[2...key.index(":_authToken")]
          @tokens[host_path] = value
        end
      end
    end

    def expand_env(value)
      value.gsub(/\$\{([^}]+)\}/) { ENV[$1] || "" }
    end
  end
end
