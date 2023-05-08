class AddFavoriteColumnToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :favorite, :boolean, default: false, null: false
  end
end
