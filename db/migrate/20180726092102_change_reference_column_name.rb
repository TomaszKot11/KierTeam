class ChangeReferenceColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :problems, :references, :reference_list
    rename_column :comments, :references, :reference_list
  end
end
