class AddBlockedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :blocked, :boolean
  end
end
