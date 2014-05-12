require 'spec_helper'

describe Peepster::API do
  include Rack::Test::Methods

  def app
    Peepster::API
  end

  describe Peepster::API do
    describe "GET /api/v1/records/gender" do
      it "returns an array of records sorted by gender, then last name" do
        get "/api/v1/records/gender"

        pending

        last_response.status.should == 200
      end

      it "calls records sorted by" do
        pending

        get "/api/v1/records/gender"

        expect(Peepster::App).to receive(:records_sorted_by)
      end
    end
  end
end