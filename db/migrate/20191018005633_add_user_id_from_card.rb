class AddUserIdFromCard < ActiveRecord::Migration[5.2]
  def change
    add_reference :cards, :user, foreign_key: true, on_delete: :cascade
  end
end
