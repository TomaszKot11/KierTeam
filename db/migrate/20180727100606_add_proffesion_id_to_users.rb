class AddProffesionIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :profession_id, :integer, index: true
  end
end
