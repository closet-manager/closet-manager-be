class ChangeTypeColumnNameFromItemsTable < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :type, :clothing_type
  end
end
