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
        expect(Peepster::App).to receive(:records_sorted_by)

        get "/records/gender"

        expect(last_response.status).to eq 200
      end

      it "returns an array of records sorted by gender (female first), then last name ascending" do
        get "/records/gender"

        expect(JSON.parse(last_response.body).first.first).to eq "Gordon"
      end
    end

    describe "GET /records/birthdate" do
      it "calls records sorted by" do
        expect(Peepster::App).to receive(:records_sorted_by)

        get "/records/birthdate"

        expect(last_response.status).to eq 200
      end

      it "returns an array of records sorted by birth date, ascending" do
        get "/records/birthdate"

        expect(JSON.parse(last_response.body).first.first).to eq "Murphy"
      end
    end

    describe "GET /records/name" do
      it "calls records sorted by" do
        expect(Peepster::App).to receive(:records_sorted_by)

        get "/records/name"

        expect(last_response.status).to eq 200
      end

      it "returns an array of records sorted by last name, descending" do
        get "/records/name"

        expect(JSON.parse(last_response.body).first.first).to eq "Wasserman"
      end
    end

    describe "POST /records" do
      let(:peep) { "Fruciante | John | Male | Red | 3/5/1970" }

      it "calls save" do
        expect(Peepster::App).to receive(:save).with(peep)

        post "/records", { :record => peep}.to_json, { 'CONTENT_TYPE' => 'application/json' }

        expect(last_response.status).to eq 201
      end
    end
  end
end