# frozen_string_literal: true

module Types
  class AddressType < Types::BaseObject
    field :id, ID, null: false
    # field :buildingAddress, String, null: false
    field :address_type, String
    # field :status, String
    # field :entity, String
    field :number_and_street, String
    field :suite_appartment, String
    field :city, String
    field :postal_code, String
    field :country, String
    field :buildingId, Integer
    field :intervention, Types::InterventionType, null: false do
      argument :id, ID, required: true
    end
    def intervention(id:)
      Intervention.find(id)
    end
    
    # field :notes, String
    # field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    # field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    # field :lat, Float
    # field :lng, Float
  end
end
