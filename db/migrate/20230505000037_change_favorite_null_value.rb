class ChangeFavoriteNullValue < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :favorite, :boolean, default: false, null: true
  end
end
