class ChangeColumnToProducts < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :products, :brands
    remove_index :products,       :brand_id
    remove_reference :products,   :brand
  end
end
