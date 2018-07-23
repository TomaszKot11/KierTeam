# Creates basic columns for Problem model
class CreateProblemUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :problem_users do |t|
      t.integer :problem_id, index: true
      t.integer :user_id, index: true

      t.timestamps
    end
  end
end
