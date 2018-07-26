require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }

  describe "#index" do
    context 'user is logged in' do
      before :each do
          user1.confirm
          sign_in(user1)
          get :index
      end

  		it { should respond_with(200..300) }
  		it { should render_template('index') }

			it 'should return all authors' do
        expect(response).to be_successful
				expect(assigns(:users)).to match_array([user1,user2])
			end
		end
	end

	describe '#show' do
    context 'user is logged in' do
      before :each do
        user1.confirm
        sign_in(user1)
        get :show, params: { id: user1.id }
      end

  		it { should respond_with(200..300) }
  		it { should render_template('show') }

			it { expect(assigns(:user)).to eq(user1) }
		end
	end
end
