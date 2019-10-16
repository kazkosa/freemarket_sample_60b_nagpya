class RenameCondeitionColumnToProducts < ActiveRecord::Migration[5.2]
  def change
    rename_column :products, :condeition, :condition
  end
end
