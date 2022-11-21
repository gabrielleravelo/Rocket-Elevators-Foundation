# frozen_string_literal: true

module Types
  class BuildingDetailType < Types::BaseObject
    field :id, ID, null: false
    field :key, String
    field :value, String
    field :building_id, Integer
  end
end
