class AddPostNumToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :post_num, :integer, null: false
  end
end
