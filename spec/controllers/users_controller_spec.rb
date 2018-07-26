require 'rails_helper'

RSpec.describe UsersController, type: :controller do

	describe "#index" do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
		before { get :index }

		it { should respond_with(200..300) }
		it { should render_template('index') }

    	context 'users' do
			it 'should return all authors' do
        expect(response).to be_successful
				expect(assigns(:users)).to match_array([user1,user2])
			end
		end
	end

	describe '#show' do
  		let(:user1) { create(:user) }
  		before { get :show, params: { id: user1.id } }

  		it { should respond_with(200..300) }
  		it { should render_template('show') }

  		context 'user' do
  			it { expect(assigns(:user)).to eq(user1) }
  		end
	end
end
