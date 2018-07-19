require 'rails_helper'

RSpec.describe Tag, type: :model do

	describe 'attributes' do
		it 'should have proper attributes' do
			expect(subject.attributes).to include('name')
		end
	end

	describe 'validators' do
		it {should validate_presence_of(:name)}
		it {should validate_length_of(:name).is_at_least(1).is_at_most(80)}
	end

	describe 'relations' do
		it {should have_many(:problems).through(:problem_tags)}
	end

end
