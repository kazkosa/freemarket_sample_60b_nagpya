class CreateProductImages < ActiveRecord::Migration[5.2]
  def change
    create_table :product_images do |t|
      t.references  :product,    null: false, foreign_key: true, on_delete: :cascade
      t.text  :image,            null: false
      t.timestamps
    end
  end
end
