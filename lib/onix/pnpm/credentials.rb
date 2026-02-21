# frozen_string_literal: true

module Onix
  module Pnpm
    module Credentials
      module_function

      ENV_SCOPED_PREFIX = "NPM_TOKEN_"

      def token_lines(project_root = Dir.pwd)
        token_map(project_root).sort_by { |host, _| host.to_s }.map do |host, token|
          "//#{host}/:_authToken=#{token}"
        end
      end

      def token_map(project_root = Dir.pwd)
        tokens = {}

        env_token_map.each do |host, token|
          tokens[normalize_registry(host)] = token
        end

        npmrc_tokens(project_root).each do |host, token|
          host = normalize_registry(host)
          tokens[host] ||= token unless token.nil? || token.empty?
        end

        %w[registry.npmjs.org npmjs.org].each do |host|
          next if tokens.key?(host)

          from_netrc = netrc_token(host)
          tokens[host] = from_netrc unless from_netrc.nil? || from_netrc.empty?
        end

        tokens
      end

      def env_token_map
        map = {}

        map["registry.npmjs.org"] = ENV["NPM_TOKEN"] if env_present?(ENV["NPM_TOKEN"])
        map["npmjs.org"] = ENV["NODE_AUTH_TOKEN"] if env_present?(ENV["NODE_AUTH_TOKEN"])

        ENV.each do |key, value|
          next unless key.start_with?(ENV_SCOPED_PREFIX)
          host = normalize_registry(key.sub(ENV_SCOPED_PREFIX, "").tr("_", ".").downcase)
          map[host] = value unless value.nil? || value.empty?
        end

        map
      end

      def env_token_for_registry(host)
        scoped = env_scoped_token(host)
        return scoped if env_present?(scoped)

        return ENV["NPM_TOKEN"] if host == "registry.npmjs.org" && env_present?(ENV["NPM_TOKEN"])
        return ENV["NODE_AUTH_TOKEN"] if host == "npmjs.org" && env_present?(ENV["NODE_AUTH_TOKEN"])

        nil
      end

      def npmrc_tokens(project_root)
        tokens = {}
        project_npmrc = project_root ? File.join(project_root, ".npmrc") : nil
        parse_npmrc_for_tokens(project_npmrc).each { |h, t| tokens[h] = t }
        parse_npmrc_for_tokens(ENV["HOME"] ? File.join(ENV["HOME"], ".npmrc") : nil).each do |h, t|
          tokens[h] ||= t
        end
        tokens
      end

      def netrc_token(host)
        return nil if ENV["HOME"].nil?

        path = File.join(ENV["HOME"], ".netrc")
        return nil unless File.exist?(path)

        machine = nil
        token = nil

        File.foreach(path) do |line|
          line = line.strip
          next if line.empty? || line.start_with?("#")

          parts = line.split
          next unless parts.length >= 2

          if parts[0] == "machine"
            if parts[1] == host
              machine = true
              password_idx = parts.index("password")
              if password_idx && parts.length > password_idx + 1
                token = parts[password_idx + 1]
                break
              end
            else
              machine = false
            end
            next
          end

          if machine && parts[0] == "password"
            token = parts[1]
            break
          end
        end

        token
      end

      def scoped_env_var_name(host)
        sanitized = host.gsub(/[^a-zA-Z0-9]/, "_").upcase
        "#{ENV_SCOPED_PREFIX}#{sanitized}"
      end

      def env_scoped_token(host)
        key = scoped_env_var_name(host)
        ENV[key]
      end

      def parse_npmrc_for_tokens(path)
        return {} if path.nil? || path.empty?
        return {} unless File.exist?(path)

        tokens = {}
        current_registry = nil

        File.foreach(path) do |line|
          cleaned = line.strip
          next if cleaned.empty? || cleaned.start_with?("#")

          if cleaned.start_with?("registry=")
            current_registry = normalize_registry(cleaned.split("=", 2).last)
            next
          end

          if cleaned =~ %r{\A//([^/:]+).*?:_authToken=(.+)\z}
            host = Regexp.last_match(1)
            tokens[normalize_registry(host)] = Regexp.last_match(2)
            next
          end

          if cleaned =~ %r{^([^\s:]+):_authToken=(.+)}
            host = Regexp.last_match(1).sub(%r{^//}, "")
            tokens[normalize_registry(host)] = Regexp.last_match(2)
            next
          end

          if current_registry && cleaned.start_with?("_authToken=")
            host = current_registry
            token = cleaned.split("=", 2).last
            tokens[host] = token unless token.empty?
          end
        end

        tokens
      rescue StandardError
        {}
      end

      def normalize_registry(host)
        return nil if host.nil?
        host.gsub(%r{\Ahttps?://}, "").gsub(%r{/.*\z}, "").downcase
      end

      def env_present?(value)
        value && !value.empty?
      end
    end
  end
end
