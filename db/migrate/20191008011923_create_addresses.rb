class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.references  :user,            null: false, foreign_key: true, on_delete: :cascade
      t.string      :prefectures,     null: false
      t.string      :municipalities,  null:false
      t.string      :block_number,    null:false
      t.string      :building
      t.string      :phone_number      
      t.timestamps
    end
  end
end
