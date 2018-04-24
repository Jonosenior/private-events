class AddCreatorIdToEvents < ActiveRecord::Migration[5.1]
  def change
    add_reference :events, :creator_id, index: true, foreign_key: true
  end
end
