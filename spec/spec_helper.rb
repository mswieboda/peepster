ENV['RACK_ENV'] ||= 'test'

require 'rubygems'
require 'bundler/setup'

require 'rack'
require 'rspec'
require 'stringio'

require File.expand_path("../../config/application", __FILE__)

require 'rack/test'

RSpec.configure do |config|
  config.mock_with :rspec
  config.include Rack::Test::Methods
end
