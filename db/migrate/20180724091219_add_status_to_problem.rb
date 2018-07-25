class AddStatusToProblem < ActiveRecord::Migration[5.2]
  def change
  	add_column :problems, :status, :boolean
  end
end
