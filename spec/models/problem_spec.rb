require 'rails_helper'

RSpec.describe Problem, type: :model do
 
	describe 'attributes' do
		it 'should have proper attributes' do
			expect(subject.attributes).to include('title', 'content', 'references')
		end
	end

	describe 'validators' do
		it { should validate_presence_of (:title) }
		it { should validate_presence_of (:content) }
		it { should validate_presence_of (:references) }
		it { should validate_length_of(:title).is_at_least(5).is_at_most(80) }
		it { should validate_length_of(:content).is_at_least(5).is_at_most(500) }
		it { should validate_length_of(:references).is_at_least(5).is_at_most(500) }
	end

	describe 'relations' do
		it { should belong_to(:creator) }
		it { should have_many(:comments) }
		it { should have_many(:users).through(:problem_users) }
		it { should have_many(:tags).through(:problem_tags) }
	end
end
