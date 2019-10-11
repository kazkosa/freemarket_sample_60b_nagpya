class ChangeDataPrefecturesToAddresses < ActiveRecord::Migration[5.2]
  def change
    change_column :addresses, :prefectures,  :integer
  end
end