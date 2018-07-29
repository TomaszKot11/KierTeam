class AddProjectToProblem < ActiveRecord::Migration[5.2]
  def change
  	add_column :problems, :project, :string
  end
end
