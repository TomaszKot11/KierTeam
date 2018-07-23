require 'rails_helper'

RSpec.describe ProblemTag, type: :model do
	
  describe 'attributes' do
		it 'should have proper attributes' do
			expect(subject.attributes).to include('problem_id', 'tag_id')
		end
	end

	describe 'should not validate presence of due to nested attributes' do 
		it { should_not validate_presence_of (:problem_id) }
		it { should_not validate_presence_of (:tag_id) }
	end
	
	describe 'relations' do
		it { should belong_to(:problem) }
		it { should belong_to(:tag) }
	end
end
