class CreateProdocts < ActiveRecord::Migration[5.2]
  def change
    create_table :prodocts do |t|
      t.string :title, null: false
      t.references :user,null: false, foreign_key: true
      t.references :category,null: false, foreign_key: true
      t.references :brand, null: false, foreign_key: true
      t.string      :shipping_charges,  null: false
      t.string      :shipping_area,     null: false
      t.string      :shipping_date,     null: false
      t.string      :shipping_method,   null: false
      t.integer     :price,             null: false
      t.string      :size,              null: false
      t.string      :description,       null: false
      t.string      :condeition,        null: false
      t.timestamps
    end
  end
end
