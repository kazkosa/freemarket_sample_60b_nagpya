class ChangeDatatypeConditionOfProducts < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :condition,        :integer
    change_column :products, :shipping_charges, :integer
    change_column :products, :shipping_date,    :integer
    change_column :products, :shipping_method,  :integer
    change_column :products, :size,             :integer
  end
end