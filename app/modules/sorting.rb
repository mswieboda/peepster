module Peepster
  module Sorting
    def sort(arr, sort)
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

    def records_sorted_by(sort, filename = "data")
      # Read to array
      peeps = File.exists?("data/#{filename}.csv") ? CSV.read("data/#{filename}.csv") : []

      # Sort array, depending on sort option
      sort(peeps, sort) unless peeps.empty?
    end
  end
end