module Peepster
  module Persistence
    def save(peeps, filename = "data")
      CSV.open("data/#{filename}.csv", "a") do |csv|
        peeps.is_a?(Array) ? peeps.each {|p| csv << p } : csv << parse(peeps)
      end

      puts 'saved peeps'
    end

    def parse(line)
      line.split(get_separator(line))
    end
  end
end