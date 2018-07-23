class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :title
      t.string :content
      t.string :references
      t.integer :problem_id, index: true

      t.timestamps
    end
  end
end
