class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :name, length: { in: 1..80 }
  has_many :problem_tags
  has_many :problems, through: :problem_tags
end
