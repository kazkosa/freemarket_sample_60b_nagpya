class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true, on_delete: :cascade
      t.references :product, foreign_key: true, on_delete: :cascade
      t.timestamps
    end
  end
end
