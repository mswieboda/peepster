ENV['RACK_ENV'] ||= :test

require 'rubygems'
require 'bundler/setup'

Bundler.require :default, ENV['RACK_ENV']

require_relative '../app/peepster'
Dir[File.expand_path('../api/*.rb', File.dirname(__FILE__))].each {|file| require file }