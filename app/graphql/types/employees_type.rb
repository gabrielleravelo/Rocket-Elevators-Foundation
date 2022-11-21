# frozen_string_literal: true

module Types
  class EmployeesType < Types::BaseObject
    field :id, ID, null: false
    field :last_name, String, null: true
    field :first_name, String, null: true
    field :title, String, null: true
    field :user_id, Integer, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :interventions, [Types::InterventionType], null: true
    
    def interventions
      FactIntervention.where(employeeId: object.id).all
    end
  end
end
