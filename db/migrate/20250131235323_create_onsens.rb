class CreateOnsens < ActiveRecord::Migration[7.2]
  def change
    create_table :onsens do |t|
      t.string :name
      t.string :address
      t.text :description
      t.integer :rating
      t.integer :price

      t.timestamps
    end
  end
end
