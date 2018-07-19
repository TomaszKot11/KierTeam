class AddUserIdToComment < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :user_id, :integer, index:true 
  end
end