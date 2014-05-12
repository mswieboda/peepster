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

  # def app
  #   Peepster::API
  # end

  config.before :each do
    $stdout = StringIO.new
  end

  config.after :all do
    $stdout = STDOUT
  end
end
