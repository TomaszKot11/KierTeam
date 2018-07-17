require 'rails_helper'

RSpec.describe Problem, type: :model do
 
	describe 'attributes' do
		it 'should have proper attributes' do
			expect(subject.attributes).to include('title', 'content', 'references')
		end
	end

	describe 'validators' do
			it { should validate_presence_of (:title)}
			it { should validate_presence_of (:content)}
			it { should validate_presence_of (:references)}

	end

	describe 'relations' do

		it { should have_many(:problem_users)}
		it { should have_many(:users)}
		it { should belong_to(:creator)}
		
	end




end
