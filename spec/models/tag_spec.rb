require 'rails_helper'

RSpec.describe Tag, type: :model do

	describe 'attributes' do
     it { should validate_uniqueness_of(:name)}
     it { should validate_presence_of(:name) }
	end

	describe 'validators' do
		it { should validate_presence_of(:name)}
		it { should validate_length_of(:name).is_at_least(1).is_at_most(80) }
	end

	describe 'relations' do
		it { should have_many(:problems).through(:problem_tags).dependent(:destroy) }
	end

end
