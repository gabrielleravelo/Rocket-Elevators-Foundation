# frozen_string_literal: true

module Types
  class BuildingType < Types::BaseObject
    field :id, ID, null: false
    field :buildingAddress, String
    field :adminFullName, String
    field :adminEmail, String
    field :adminPhoneNumber, String
    field :technicalContactFullName, String
    field :technicalContactEmail, String
    field :technicalContactPhoneNumber, String
    field :customer_id, Integer
    field :customer, Types::CustomerType, null: true
    field :inItervention, [Types::InterventionType] , null: true
    def customer
      object.customer
      
    end

    def inItervention
            FactIntervention.where(buildingId: object.id)

    end
  end
end
