class CreateInterventions < ActiveRecord::Migration[5.2]
  def change
    create_table :interventions do |t|
      t.integer :author
      t.integer :customerId
      t.integer :buildingId
      t.integer :batteryId
      t.integer :columnId
      t.integer :elevatorId
      t.integer :employeeId
      t.timestamp :interventionStartAt
      t.timestamp :interventionEndAt
      t.string :result
      t.text :report
      t.string :status
    end
  end
end
