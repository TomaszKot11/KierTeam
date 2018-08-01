require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let!(:user1) { create(:user, blocked:false) }
  let!(:user2) { create(:user) }
  let!(:user_admin) {create(:user, is_admin:true)}

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
				expect(assigns(:users)).to match_array([user1,user2,user_admin])
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

  describe '#destroy' do
    subject(:delete_user) { delete :destroy, format: :js, params: { id: user1.id } }

    context 'user is admin and logged in ' do
      before :each do
        user_admin.confirm
        sign_in(user_admin)
      end
      it 'should destroy user' do
        expect { delete_user }.to change { User.count }.by(-1)
      end
    end

    context 'user is not admin and logged in ' do
      before :each do
        user1.confirm
        sign_in(user1)
      end
      it 'should not destroy user' do
        expect { delete_user }.to change { User.count }.by(0)
      end
    end
  end

  describe '#ban' do
    let(:ban_attributes) {{ id: user1.id, user: { blocked:true } }}
    subject(:ban_user) { put :ban, params: ban_attributes }

    context 'user is admin and logged in ' do
      before :each do
        user_admin.confirm
        sign_in(user_admin)
      end
      it 'should ban user' do
        ban_user
        expect(user1.reload.blocked).to eq(true)
      end
    end

    context 'user is not admin and logged in ' do
      before :each do
        user1.confirm
        sign_in(user1)
      end
      it 'should ban user' do
        ban_user
        expect(user1.reload.blocked).to eq(false)
      end
    end

  end

end
