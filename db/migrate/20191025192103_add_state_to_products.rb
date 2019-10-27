class AddStateToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :state, :integer, default: 0
  end
end
