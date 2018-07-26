class Comment < ApplicationRecord
  validates :title, :content, :reference_list, presence: true
  validates :title, length: { in: 5..80 }
  validates :content, :reference_list, length: { in: 5..500 }
  belongs_to :problem
  belongs_to :user
end
