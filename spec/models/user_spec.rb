require 'rails_helper'

RSpec.describe User, type: :model do
 
  	describe 'attributes' do
		it 'should have proper attributes' do
			expect(subject.attributes).to include('name', 'surname', 'position')
		end
	end

	describe 'Validators' do
			it { should validate_presence_of (:name)}
			it { should validate_presence_of (:surname)}
			it { should validate_presence_of (:position)}

	end

	describe 'relations' do

		it { should have_many(:problems)}
		it { should have_many(:problem_users)}
	end
end
