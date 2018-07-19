
class ProblemUser < ApplicationRecord
	# optional ? 
	belongs_to :problem
	belongs_to :user


	accepts_nested_attributes_for :problem
end
