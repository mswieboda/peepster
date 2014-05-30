module Peepster
  module CsvUtilities
    def get_separator(line)
      [' | ', ', ', ' '].each do |sep|
        return sep if line.scan(sep).length == 4
      end

      return nil
    end
  end
end