#!/usr/bin/env ruby

require 'csv'

module Peepster
  class App
    def self.save(peeps, filename = "data")
      CSV.open("data/#{filename}.csv", "a") do |csv|
        peeps.first.is_a?(Array) ? peeps.each {|p| csv << p } : csv << peeps
      end

      puts 'saved peeps'
    end

    def self.sort(arr, sort)
      if sort == :gender
        # Gender F first, Last name asc
        arr.sort {|x, y| [x[2].capitalize, x[0].capitalize] <=> [y[2].capitalize, y[0].capitalize] }
      elsif sort == :birthdate
        # Birth date asc
        arr.sort {|x, y| Date.strptime(x[4], '%m/%d/%Y') <=> Date.strptime(y[4], '%m/%d/%Y') }
      elsif sort == :name
        # Last name desc
        arr.sort {|x, y| y[0] <=> x[0] }
      else
        arr
      end
    end

    def self.records_sorted_by(sort, filename = "data")
      # Read to array
      peeps = File.exists?("data/#{filename}.csv") ? CSV.read("data/#{filename}.csv") : []

      # Sort array, depending on sort option
      sort(peeps, sort) unless peeps.empty?
    end

    def self.output(peeps)
      peeps.each do |p|
        date = Date.strptime(p[4], '%m/%d/%Y').strftime('%-m/%-d/%Y')
        puts "#{p[0].capitalize} : #{p[1].capitalize} : #{p[2].capitalize} : #{date} : #{p[3].capitalize}"
      end

      puts 'outputted peeps'
    end

    def self.get_separator(line)
      [' | ', ', ', ' '].each do |sep|
        return sep if line.scan(sep).length == 4
      end

      return nil
    end

    # Has an argument, and is not rspec running
    if ARGV.length > 0 && "#{$0}" !~ /rspec/
      sort = :gender if ARGV.delete('--gender')
      sort = :birthdate if ARGV.delete('--birthdate')
      sort = :name if ARGV.delete('--name')
      sort ||= :gender

      peeps = []

      ARGV.each_with_index do |a, i|
        sep = get_separator(File.open(a) {|f| f.readline})
        CSV.foreach(a, { :col_sep => sep }) {|row| peeps << row }
      end

      save(peeps)
      output(records_sorted_by(sort))
    end
  end
end