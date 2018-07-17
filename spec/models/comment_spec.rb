require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'relations' do
		it { should belong_to(:problem)}
	end
end
