class Profession < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :name, length: { in: 1..80 }
  has_many :users
end
