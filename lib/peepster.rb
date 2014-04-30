#!/usr/bin/env ruby

require 'csv'

class Peepster
  def create
    records = [["Matt", "Swieboda", "Male", "Red", "4/5/1989"],["John", "Pec", "Male", "Blue", "4/5/1999"],["Nico", "Bob", "Male", "Red", "4/5/1987"]]

    CSV.open("data/data-#{ENV['RAILS_ENV']}.csv", "a+b") do |csv|
      records.each {|r| csv << r }
    end

    puts 'saved peeps'
  end

  def output
    CSV.foreach("data/data-#{ENV['RAILS_ENV']}.csv") do |row|
      puts row.inspect
    end

    puts 'outputted peeps'
  end
end