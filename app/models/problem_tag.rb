class ProblemTag < ApplicationRecord
	validates :problem_id, :tag_id, presence: true

	belongs_to :problem 
	belongs_to :tag
end
