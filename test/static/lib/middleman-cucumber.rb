require 'bundler/setup'
require 'middleman'
require_relative "middleman_cucumber/test_env"

module Middleman
  module Cucumber
    env = (ENV["MM_ENV"] || "test").to_sym

    puts "The Middleman is preparing to serve your Cucumbers in #{env.to_s}"

    Bundler.require :default, env
    @app = ::Middleman.server.inst do
      set :environment, env
      set :logging, true
    end

    def self.rack_app(opts={})
      @app.class.to_rack_app
    end

  end
end