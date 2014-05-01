require 'spec_helper.rb'
require 'peepster'

describe Peepster do
  let(:peep) { ["Frusciante", "Trinity", "Female", "Green", "3/13/1989"] }
  let(:peeps) { [peep, ["Knowles", "Tyler", "Male", "Red", "4/5/1979"],
                ["Jett", "Clementine", "Female", "Black", "9/5/1991"]] }

  describe "command line" do
    context "with file args" do
      let(:output) { `ruby lib/peepster.rb spec/fixtures/test1.csv spec/fixtures/test2.csv spec/fixtures/test3.csv` }
      before(:each) { output }
      after(:each) { File.delete("data/data.csv") }

      it "creates a csv file" do
        expect(File.exists?("data/data.csv")).to be
      end

      it "outputs to command line" do
        expect(output).to match(/saved peeps/)
        expect(output).to match(/outputted peeps/)
      end

      it "combines all inputed data" do
        # Tested by checking number of lines
        orig_count = 0

        %w(spec/fixtures/test1.csv spec/fixtures/test2.csv spec/fixtures/test3.csv).each do |file|
          orig_count += File.open(file,"r").readlines.size
        end

        combo_count = File.open("data/data.csv").readlines.size

        expect(combo_count).to eq orig_count
      end
    end

    context "with sort options" do
      after(:each) { File.delete("data/data.csv") }

      it "sorts by gender" do
        output = `ruby lib/peepster.rb --gender spec/fixtures/test3.csv`
        expect(output).to match(/saved peeps\nGordon/)
      end

      it "sorts by date of birth" do
        output = `ruby lib/peepster.rb --birth spec/fixtures/test2.csv`
        expect(output).to match(/saved peeps\nHendrix/)
      end

      it "sorts by last name" do
        output = `ruby lib/peepster.rb --last spec/fixtures/test1.csv`
        expect(output).to match(/saved peeps\nClapton/)
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
    context "given chunk of peeps" do
      it "creates a csv file of peeps" do
        Peepster.save(peeps, "test")

        expect(File.exist?("data/test.csv")).to be
        expect($stdout.string).to match(/saved/)

        File.delete("data/test.csv")
      end
    end

    context "given one peep" do
      it "raises an error trying to map array" do
        expect{ Peepster.save(peep, "test") }.to raise_error(NoMethodError)
      end
    end
  end

  describe ".sort" do
    context "sort option 1" do
      it "sorts peeps by gender (f first), then last name asc" do
        sorted_peeps = Peepster.sort(peeps, 1)

        expect(sorted_peeps[0].first).to eq "Frusciante"
        expect(sorted_peeps[1].first).to eq "Jett"
      end
    end

    context "sort option 2" do
      it "sorts peeps by birth date, asc" do
        sorted_peeps = Peepster.sort(peeps, 2)

        expect(sorted_peeps[0].first).to eq "Knowles"
        expect(sorted_peeps[1].first).to eq "Frusciante"
      end
    end

    context "sort options 3" do
      it "sorts peeps by last name desc" do
        sorted_peeps = Peepster.sort(peeps, 3)

        expect(sorted_peeps[0].first).to eq "Frusciante"
        expect(sorted_peeps[1].first).to eq "Jett"
      end
    end

    context "no valid sort option" do
      it "does not sort" do
        sorted_peeps = Peepster.sort(peeps, 5)

        expect(sorted_peeps[0].first).to eq "Frusciante"
        expect(sorted_peeps[1].first).to eq "Knowles"
      end
    end
  end

  describe ".output" do
    before(:each) do
      Peepster.save(peeps, "test")
    end

    after(:each) { File.delete("data/test.csv") }

    it "sorts using .sort" do
      # stub .sort since it's already tested
      allow(Peepster).to receive(:sort).and_return(peeps)
      expect(Peepster).to receive(:sort)

      Peepster.output(1, "test")
    end

    it "outputs existing csv file of peeps" do
      Peepster.output(1, "test")

      expect($stdout.string).to match(/Frusciante/)
      expect($stdout.string).to match(/outputted/)
    end

    it "outputs dates in M/D/YYYY format" do
      Peepster.output(1, "test")

      expect($stdout.string).to match(/3\/13\/1989/)
    end
  end
end