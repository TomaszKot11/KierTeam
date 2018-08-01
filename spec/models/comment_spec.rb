require 'rails_helper'

RSpec.describe Comment, type: :model do
	describe 'attributes' do
		it 'should have proper attributes' do
			expect(subject.attributes).to include('title', 'content', 'reference_list')
		end
	end

	describe 'validators' do
		it { should validate_presence_of (:title)}
		it { should validate_presence_of (:content)}
		it { should validate_length_of(:title).is_at_least(5).is_at_most(160)}
		it { should validate_length_of(:content).is_at_least(5).is_at_most(1500)}
	end

	describe 'relations' do
		it { should belong_to(:problem)}
	end
end
