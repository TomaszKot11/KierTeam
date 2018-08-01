class Comment < ApplicationRecord
  validates :title, :content, presence: true
  validates :title, length: { in: 5..160 }
  validates :content, length: { in: 5..1500 }
  belongs_to :problem
  belongs_to :user
end
