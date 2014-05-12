require 'json'

module Peepster
  class API < Grape::API
    format :json
    resource :records do
      desc "Returns records sorted by gender."
      get :gender do
        Peepster::App.records_sorted_by(:gender)
      end
    end
  end
end