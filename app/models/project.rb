class Project < ApplicationRecord
  validates :title, :description, presence: true
  validates :title, length: {in: 3..80}
  validates :description, length: {in: 3..500}
end
