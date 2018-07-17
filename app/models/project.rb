class Project < ApplicationRecord

	t.string :title
      t.string :description
      t.datetime :started_at
      t.datetime :ended_at

  validates :title, :description, :started_at, :ended_at, presence: true
  validates :title, length: {in: 3..40}
  validates :description, length: {in: 3..500}

end
