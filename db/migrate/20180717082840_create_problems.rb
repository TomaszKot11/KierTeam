# creates problems table and adds basic columns
class CreateProblems < ActiveRecord::Migration[5.2]
  def change
    create_table :problems do |t|
      t.string :title
      t.string :content
      t.string :references
      t.integer :creator_id

      t.timestamps
    end
  end
end
