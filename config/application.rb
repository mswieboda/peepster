ENV['RACK_ENV'] ||= :test

require 'rubygems'
require 'bundler/setup'

Bundler.require :default, ENV['RACK_ENV']

require File.expand_path('../../app/peepster', __FILE__)
require File.expand_path('../../api/api', __FILE__)

