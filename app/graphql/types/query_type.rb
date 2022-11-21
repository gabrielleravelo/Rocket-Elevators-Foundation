module Types
  class QueryType < Types::BaseObject
    field :address, [Types::AddressType], null: false
    def address
      Address.all
      FactIntervention.where.not(interventionStartAt: nil)
    end
    
    # Get all employees
    field :employees, [Types::EmployeesType], null: false
    def employees
      Employee.all
    end

    # # Get a specific employee
    field :employee, Types::EmployeesType, null: false do
      argument :id, ID, required: true
    end
    def employee(id:)
      Employee.find(id)
    end

    # Get all interventions
    field :interventions, [Types::InterventionType], null: false
    def interventions
      FactIntervention.all
    end

    # Get a specific intervention
    field :intervention, Types::InterventionType, null: false do
      argument :id, ID, required: true
    end
    def intervention(id:)
      FactIntervention.find(id)
    end
    
    
    field :buildings, [Types::BuildingType], null: false

    def buildings
      Building.all
    end
    
    ######################
    
    
    
    # Get a specific building
    field :building, Types::BuildingType, null: false do
      argument :id, ID, required: false 
      
    end
    def building(id:)
      Building.find(id)

    end
  end
end