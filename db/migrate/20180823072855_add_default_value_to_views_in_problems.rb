class AddDefaultValueToViewsInProblems < ActiveRecord::Migration[5.2]
  def change
    change_column :problems, :views, :int, default: 0
  end
end
