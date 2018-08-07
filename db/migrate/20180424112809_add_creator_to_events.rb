class AddCreatorToEvents < ActiveRecord::Migration[5.1]
  def change
    add_reference :events, :creator, index: true, {to_table: :users}
  end
end
