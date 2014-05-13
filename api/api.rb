require 'json'

module Peepster
  class API < Grape::API
    format :json

    resource :records do
      desc "Returns records sorted by gender"
      get :gender do
        Peepster::App.records_sorted_by(:gender)
      end

      desc "Returns records sorted by birthdate"
      get :birthdate do
        Peepster::App.records_sorted_by(:birthdate)
      end

      desc "Returns records sorted by name"
      get :name do
        Peepster::App.records_sorted_by(:name)
      end
    end
  end
end