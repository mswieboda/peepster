#!/usr/bin/env ruby

require 'csv'

class Peepster
  def self.save(peeps, filename = "data")
    CSV.open("data/#{filename}.csv", "w") do |csv|
      peeps.each {|p| csv << p }
    end

    puts 'saved peeps'
  end

  def self.sort(arr, sort)
    if sort == 1
      # Gender F first, Last name asc
      arr.sort {|x, y| [x[2].capitalize, x[0].capitalize] <=> [y[2].capitalize, y[0].capitalize] }
    elsif sort == 2
      # Birth date asc
      arr.sort {|x, y| Date.strptime(x[4], '%m/%d/%Y') <=> Date.strptime(y[4], '%m/%d/%Y') }
    elsif sort == 3
      # Last name desc
      arr.sort {|x, y| x[0] <=> y[0] }
    else
      arr
    end
  end

  def self.output(sort, filename = "data")
    # Read it to array
    peeps = CSV.read("data/#{filename}.csv")

    # Sort array, depending on sort option
    peeps = sort(peeps, sort)

    # Output array
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
    sort = 1 if ARGV.delete('--gender')
    sort = 2 if ARGV.delete('--birth')
    sort = 3 if ARGV.delete('--last')
    sort ||= 1

    peeps = []

    ARGV.each_with_index do |a, i|
      sep = get_separator(File.open(a) {|f| f.readline})
      CSV.foreach(a, { :col_sep => sep }) {|row| peeps << row }
    end

    save(peeps)
    output(sort)
  end
end