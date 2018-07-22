class Comment < ApplicationRecord
	validates :title, :content, :references, presence: true
  	validates :title, length: {in: 5..80}
  	validates :content,:references, length: {in: 5..500}

	belongs_to :problem
	belongs_to :user
end
