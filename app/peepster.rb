#!/usr/bin/env ruby

require 'csv'

Dir[File.expand_path('modules/*.rb', File.dirname(__FILE__))].each {|file| require file }

module Peepster
  extend Peepster::Persistence
  extend Peepster::Sorting
  extend Peepster::Output
  extend Peepster::CsvUtilities

  # Has an argument, and is not rspec running
  if ARGV.length > 0 && "#{$0}" !~ /rspec/
    sort = :gender if ARGV.delete('--gender')
    sort = :birthdate if ARGV.delete('--birthdate')
    sort = :name if ARGV.delete('--name')
    sort ||= :gender

    peeps = []

    ARGV.each_with_index do |a, i|
      sep = Peepster.get_separator(File.open(a) {|f| f.readline})
      CSV.foreach(a, { :col_sep => sep }) {|row| peeps << row }
    end

    Peepster.save(peeps)
    Peepster.output(Peepster.records_sorted_by(sort))
  end
end