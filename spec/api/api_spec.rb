require 'spec_helper'

describe Peepster::API do
  include Rack::Test::Methods

  def app
    Peepster::API
  end

  describe Peepster::API do
    let(:output) { `ruby app/peepster.rb spec/fixtures/test1.csv spec/fixtures/test2.csv spec/fixtures/test3.csv` }
    before(:each) { output }
    after(:each) { File.delete("data/data.csv") }

    describe "GET /records/gender" do
      it "calls records sorted by" do
        get "/records/gender"

        expect(last_response.status).to eq 200
      end

      it "returns an array of records sorted by gender (female first), then last name ascending"
    end

    describe "GET /records/birthdate" do
      it "calls records sorted by" do
        get "/records/birthdate"

        expect(last_response.status).to eq 200
      end

      it "returns an array of records sorted by birth date, ascending"
    end

    describe "GET /records/name" do
      it "calls records sorted by" do
        get "/records/name"

        expect(last_response.status).to eq 200
      end

      it "returns an array of records sorted by last name, descending"
    end
  end
end