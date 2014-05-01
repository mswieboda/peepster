require 'spec_helper.rb'
require 'peepster'

describe Peepster do
  describe "command line" do
    context "with args" do
      after(:each) { File.delete("data/data.csv") }

      it "creates a csv file of peeps from all inputed files" do
        output = `ruby lib/peepster.rb spec/fixtures/test1.csv spec/fixtures/test2.csv spec/fixtures/test3.csv`
        expect(output).to match(/saved peeps/)
      end
    end

    context "without args" do
      it "does nothing" do
        output = `ruby lib/peepster.rb`
        expect(output).not_to match(/saved peeps/)
      end
    end
  end

  describe ".get_separator" do
    context "line contains '|' separators" do
      it "returns ' | '" do
        expect(Peepster.get_separator("L | F | Male | Red | 3/13/2013")).to eq ' | '
      end
    end

    context "line contains ',' separators" do
      it "returns ', '" do
        expect(Peepster.get_separator("L, F, Male, Red, 3/13/2013")).to eq ', '
      end
    end

    context "line contains ' ' separators" do
      it "returns ' '" do
        expect(Peepster.get_separator("L F Male Red 3/13/2013")).to eq ' '
      end
    end

    context "line does not contain known separators" do
      it "returns nil" do
        expect(Peepster.get_separator("L*F*Male*Red*3/13/2013")).to eq nil
      end
    end
  end

  describe ".save" do
    context "given chunk" do
      it "creates a csv file of peeps" do
        Peepster.save([["a", "b", "c"], ["d", "e", "f"]], "test")

        expect(File.exist?("data/test.csv")).to be
        expect($stdout.string).to match(/saved/)

        File.delete("data/test.csv")
      end
    end

    context "given flat array" do
      it "raises an error trying to map array" do
        expect{ Peepster.save(["a", "b", "c"], "test") }.to raise_error(NoMethodError)
      end
    end
  end

  describe ".sort" do
    context "sort option 1" do
      it "sorts peeps by gender (f first), then last name asc"
    end

    context "sort option 2" do
      it "sorts peeps by birth date, asc"
    end

    context "sort options 3" do
      it "sorts peeps by last name desc" do
        expect(Peepster.sort([["z"], ["x"], ["c"]], 3).first.first).to eq "c"
      end
    end

    context "no valid sort option" do
      it "does not sort" do
        peeps = Peepster.sort([["z"], ["x"], ["c"]], 5)

        expect(peeps[0].first).to eq "z"
        expect(peeps[1].first).to eq "x"
      end
    end
  end

  describe ".output" do
    it "outputs existing csv file of peeps" do
      Peepster.save([["L", "F", "Male", "Red", "3/13/2013"], ["L", "F", "Female", "Green", "9/01/2013"]])
      Peepster.output("test")

      expect($stdout.string).to match(/outputted/)

      File.delete("data/test.csv")
    end

    it "outputs dates in M/D/YYYY format"
  end
end