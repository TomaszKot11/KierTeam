class AddViewsToProblem < ActiveRecord::Migration[5.2]
  def change
    add_column :problems, :views, :int
  end
end
