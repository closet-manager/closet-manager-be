class AddNullValuesToColumns < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :season, :integer, default: 0
    change_column :items, :clothing_type, :integer, default: 0
    change_column :items, :size, :string, :null => true
    change_column :items, :color, :integer, default: 0
    change_column :items, :notes, :string, :null => true
  end
end
