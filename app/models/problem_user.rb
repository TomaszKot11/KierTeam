
class ProblemUser < ApplicationRecord

	validates :problem_id, :user_id, presence: true

	belongs_to :problem 
	belongs_to :user
end
