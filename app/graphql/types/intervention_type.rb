# frozen_string_literal: true

module Types
  class InterventionType < Types::BaseObject
    field :id, ID, null: false
    field :employeeId, Integer, null: false
    field :batteryId, Integer, null: false
    field :columnId, Integer, null: true
    field :elevatorId, Integer, null: true
    field :result, String, null: false
    field :report, String, null: false
    field :status, String, null: false
    field :buildingId, Integer, null: false
    field :interventionStartAt, String, null: false
    field :interventionEndAt, String
    field :building, Types::BuildingType , null: true
    def building
      Building.find(object.buildingId)
    end
    
    field :buildingdetail, Types::BuildingDetailType, null: false
    def buildingdetail
       BuildingDetail.find(object.buildingId)
    end

  end
end
