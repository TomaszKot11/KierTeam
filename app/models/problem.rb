
class Problem < ApplicationRecord

  validates :title, :content, :references, presence: true
  validates :title, length: {in: 5..60}
  validates :content, length: {in: 5..500}
  validates :references, length: {in: 5..500}

  belongs_to :creator, class_name: 'User'

  has_many :comments

  has_many :problem_users
  has_many :users, through: :problem_users

  has_many :problem_tags
  has_many :tags, through: :problem_tags


  # to test
  accepts_nested_attributes_for :problem_users
end
