class FactIntervention < ActiveRecord::Migration[5.2]
  def change
    create_table :fact_interventions do |t|
      t.integer :employeeId
      t.integer :buildingId
      t.integer :batteryId
      t.integer :columnId
      t.integer :elevatorId
      t.timestamp :interventionStartAt
      t.timestamp :interventionStartAt
      t.timestamp :interventionEndAt
      t.string :result
      t.text :report
      t.string :status
    end
  end
end
