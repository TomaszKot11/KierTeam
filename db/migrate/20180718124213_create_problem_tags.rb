class CreateProblemTags < ActiveRecord::Migration[5.2]
  def change
    create_table :problem_tags do |t|
      t.integer :problem_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
