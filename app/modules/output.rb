module Peepster
  module Output
    def output(peeps)
      peeps.each do |p|
        date = Date.strptime(p[4], '%m/%d/%Y').strftime('%-m/%-d/%Y')
        puts "#{p[0].capitalize} : #{p[1].capitalize} : #{p[2].capitalize} : #{date} : #{p[3].capitalize}"
      end

      puts 'outputted peeps'
    end
  end
end