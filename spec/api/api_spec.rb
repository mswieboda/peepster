require 'spec_helper'

describe Peepster::API do
  include Rack::Test::Methods

  def app
    Peepster::API
  end

  describe Peepster::API do
    describe "GET /records/gender" do
      it "calls records sorted by"
      it "returns an array of records sorted by gender (female first), then last name ascending"
    end

    describe "GET /records/birthdate" do
      it "calls records sorted by"
      it "returns an array of records sorted by birth date, ascending"
    end

    describe "GET /records/name" do
      it "calls records sorted by"
      it "returns an array of records sorted by last name, descending"
    end
  end
end