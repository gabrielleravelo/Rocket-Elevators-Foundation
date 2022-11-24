class CreateInterventions < ActiveRecord::Migration[5.2]
  def change
    create_table :interventions do |t|
      t.integer :author, null: false
      t.integer :customerId, null: false
      t.integer :buildingId, null: false
      t.integer :batteryId, null: false
      t.integer :columnId
      t.integer :elevatorId
      t.integer :employeeId
      t.timestamp :interventionStartAt
      t.timestamp :interventionEndAt
      t.string :result, null: false, default: "Incomplete"
      t.text :report
      t.string :status, null: false, default: "Pending"
    end
  end
end
