class RemoveAttachedFileFromLeads < ActiveRecord::Migration[5.2]
  def change
    remove_column :leads, :attached_file, :binary
  end
end
