class CreateTrials < ActiveRecord::Migration[5.2]
  def change
    create_table :trials do |t|
      t.text  :image #For trial
      t.timestamps
    end
  end
end
