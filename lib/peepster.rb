#!/usr/bin/env ruby

require 'csv'

class Peepster
  def self.save(arr, filename = "data")
    CSV.open("data/#{filename}.csv", "w") do |csv|
      arr.each {|r| csv << r }
    end

    puts 'saved peeps'
  end

  def self.output(filename = "data")
    CSV.foreach("data/#{filename}.csv") do |row|
      puts "#{row[0]} : #{row[1]} : #{row[2]} : #{row[4]} : #{row[3]}"
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
    peeps = []

    ARGV.each_with_index do |a|
      sep = get_separator(File.open(a) {|f| f.readline})
      peeps = CSV.read(a, { :col_sep => sep })
    end

    save(peeps)
    output
  end
end