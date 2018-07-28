class DeletePositionFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :position
  end
end
