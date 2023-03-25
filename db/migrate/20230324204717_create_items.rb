class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :user, foreign_key: true
      t.integer :season
      t.integer :type
      t.string :size
      t.integer :color
      t.string :image_url
      t.string :notes

      t.timestamps
    end
  end
end
