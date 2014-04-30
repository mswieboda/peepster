require 'spec_helper.rb'
require 'peepster'

describe Peepster do
  describe "#create" do
    it "creates a csv file of records array" do
      p = Peepster.new
      p.create

      expect(File.exist?("data/data-test.csv")).to be
      expect($stdout.string).to match(/saved/)

      File.delete("data/data-test.csv")
    end
  end

  describe "#output" do
    it "reads existing csv file of records array" do
      p = Peepster.new
      p.create
      p.output

      expect($stdout.string).to match(/outputted/)

      File.delete("data/data-test.csv")
    end
  end
end