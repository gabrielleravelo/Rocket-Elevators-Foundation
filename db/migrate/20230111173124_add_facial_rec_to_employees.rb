class AddFacialRecToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :facial_rec, :json
  end
end
