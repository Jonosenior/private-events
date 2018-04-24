class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.datetime :date_time
      t.string :location

      t.timestamps
    end
  end
end
