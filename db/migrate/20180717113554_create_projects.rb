# Creates Project table and adds basic columns
class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :description
      t.datetime :started_at
      t.datetime :ended_at

      t.timestamps
    end
  end
end
