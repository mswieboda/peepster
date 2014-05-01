#!/usr/bin/env ruby

require 'csv'

class Peepster
  def self.save(peeps, filename = "data")
    CSV.open("data/#{filename}.csv", "w") do |csv|
      peeps.each {|p| csv << p }
    end

    puts 'saved peeps'
  end

  def self.sort(arr, sort = 3)
    if sort == 3
      # Last name descending
      arr.sort { |x, y| x[0] <=> y[0] }
    else
      arr
    end
  end

  def self.output(filename = "data", sort = 3)
    # Read it to array
    peeps = CSV.read("data/#{filename}.csv")

    # Sort array, depending on sort option
    peeps = sort(peeps, sort)

    # Output array
    # Dates (p[4]) in M/D/YYYY
    peeps.each {|p| puts "#{p[0]} : #{p[1]} : #{p[2]} : #{p[4]} : #{p[3]}" }

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