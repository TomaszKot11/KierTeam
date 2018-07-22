require 'rails_helper'

RSpec.describe Project, type: :model do

	describe 'attributes' do
		it 'should have proper attributes' do
			expect(subject.attributes).to include('title', 'description')
		end
	end

	describe 'validators' do 
		it { should validate_presence_of (:title)}
		it { should validate_presence_of (:description)}
		it { should validate_length_of(:title).is_at_least(3).is_at_most(80)}
		it { should validate_length_of(:description).is_at_least(3).is_at_most(500)}
	end

end
