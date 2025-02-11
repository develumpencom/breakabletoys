class AddKitIdToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :kit_id, :string
    add_column :users, :kit_state, :string
  end
end
