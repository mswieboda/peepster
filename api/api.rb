require 'json'

module Peepster
  class API < Grape::API
    format :json

    resource :records do
      desc "Returns records sorted by gender"
      get :gender do
        Peepster.records_sorted_by(:gender)
      end

      desc "Returns records sorted by birthdate"
      get :birthdate do
        Peepster.records_sorted_by(:birthdate)
      end

      desc "Returns records sorted by name"
      get :name do
        Peepster.records_sorted_by(:name)
      end

      desc "Add a single record"
      post '/' do
        Peepster.save(params[:record])
      end
    end
  end
end