# frozen_string_literal: true

require_relative "test_helper"
require_relative "../lib/onix/pnpm/credentials"

class PnpmCredentialsTest < Minitest::Test
  def with_home
    original_home = ENV["HOME"]
    Dir.mktmpdir do |home|
      ENV["HOME"] = home
      yield home
    end
  ensure
    ENV["HOME"] = original_home
  end

  def with_env
    saved = ENV.to_h.slice("NPM_TOKEN", "NODE_AUTH_TOKEN", "NPM_TOKEN_NPMJS_ORG", "NPM_TOKEN_REGISTRY_NPMJS_ORG")
    ENV.delete("NPM_TOKEN")
    ENV.delete("NODE_AUTH_TOKEN")
    ENV.delete("NPM_TOKEN_NPMJS_ORG")
    ENV.delete("NPM_TOKEN_REGISTRY_NPMJS_ORG")
    yield
  ensure
    saved.each { |name, value| ENV[name] = value }
  end

  def test_token_lines_prefers_env_over_npmrc
    with_home do
      with_env do
        Dir.mktmpdir do |project|
          File.write(File.join(project, ".npmrc"), "//registry.npmjs.org/:_authToken=project-token\n")
          File.write(File.join(ENV["HOME"], ".npmrc"), "//registry.npmjs.org/:_authToken=home-token\n")
          ENV["NPM_TOKEN"] = "env-token"

          lines = Onix::Pnpm::Credentials.token_lines(project)

          assert_equal %w[//registry.npmjs.org/:_authToken=env-token], lines
        end
      end
    end
  end

  def test_token_lines_uses_project_npmrc_over_home_npmrc
    with_home do
      with_env do
        Dir.mktmpdir do |project|
          File.write(File.join(project, ".npmrc"), "//registry.npmjs.org/:_authToken=project-token\n//custom.example/:_authToken=custom-project\n")
          File.write(File.join(ENV["HOME"], ".npmrc"), "//registry.npmjs.org/:_authToken=home-token\n//custom.example/:_authToken=custom-home\n")

          lines = Onix::Pnpm::Credentials.token_lines(project)

          assert_equal 2, lines.size
          assert_includes(lines, "//custom.example/:_authToken=custom-project")
          assert_includes(lines, "//registry.npmjs.org/:_authToken=project-token")
          assert_equal %w[
            //custom.example/:_authToken=custom-project
            //registry.npmjs.org/:_authToken=project-token
          ], lines
        end
      end
    end
  end

  def test_token_lines_supports_host_scoped_env
    with_home do
      with_env do
        Dir.mktmpdir do |project|
          File.write(File.join(ENV["HOME"], ".npmrc"), "//registry.npmjs.org/:_authToken=home-token\n")
          ENV["NPM_TOKEN_REGISTRY_NPMJS_ORG"] = "scoped-token"

          lines = Onix::Pnpm::Credentials.token_lines(project)

          assert_includes(lines, "//registry.npmjs.org/:_authToken=scoped-token")
          assert_equal 1, lines.size
        end
      end
    end
  end

  def test_token_lines_falls_back_to_netrc_for_npm_hosts
    with_home do
      with_env do
        Dir.mktmpdir do |project|
          netrc = File.join(ENV["HOME"], ".netrc")
          File.write(netrc, "machine registry.npmjs.org password netrc-token\n")

          lines = Onix::Pnpm::Credentials.token_lines(project)

          assert_equal %w[//registry.npmjs.org/:_authToken=netrc-token], lines
        end
      end
    end
  end
end
