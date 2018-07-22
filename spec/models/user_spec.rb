require 'rails_helper'

RSpec.describe User, type: :model do
 
  	describe 'attributes' do
		it 'should have proper attributes' do
			expect(subject.attributes).to include('name', 'surname', 'position')
		end
	end

	describe 'validators' do
		it { should validate_presence_of (:name)}
		it { should validate_presence_of (:surname)}
		it { should validate_presence_of (:position)}
		it { should validate_length_of(:name).is_at_least(3).is_at_most(80)}
		it { should validate_length_of(:surname).is_at_least(3).is_at_most(80)}
		it { should validate_length_of(:position).is_at_least(3).is_at_most(80)}
	end

	describe 'relations' do
		it { should have_many(:created_problems).with_foreign_key('creator_id').class_name('Problem')}
		it { should have_many(:problems).through(:problem_users)}
	end
end
