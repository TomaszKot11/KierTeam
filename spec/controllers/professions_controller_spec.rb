require 'rails_helper'

RSpec.describe ProfessionsController, type: :controller do

  let!(:user_not_admin) { create(:user) }
  let!(:user_admin) { create(:user, is_admin:true) }

  describe 'index' do
    let!(:profession1) {create(:profession)}
    let!(:profession2) {create(:profession)}
    subject(:get_index) { get :index }

    context 'user is admin and logged in' do
      before :each do
        user_admin.confirm
        sign_in(user_admin)
        get_index
      end

      # it 'should assing to @professions variable' do
      #   expect(assigns(:professions)).to match_array([profession1, profession2])
      # end

      it 'should render proper template' do
        expect(response).to be_successful
        expect(response).to render_template('index')
      end
    end

    context 'user is not admin and logged in' do
      before :each do
        user_not_admin.confirm
        sign_in(user_not_admin)
        get_index
      end

      it 'should be redirected to root path with alert message' do
        expect(response).to redirect_to :root
        expect(flash[:alert]).to be_present
      end
    end

    context 'user is not logged in' do
      it 'should be redirected to login panel with alert message' do
        expect(get_index).to redirect_to :new_user_session
        expect(flash[:alert]).to be_present
      end
    end
  end

# ------------------------------------------------------------------------

describe '#edit' do
    let!(:profession1) { create(:profession, name:'profession1_name') }
    let!(:valid_attributes) { { id: profession1.id, profession: {name: 'profession1_name'}}}
    subject(:edit_profession) { get :edit, params: valid_attributes  }

    context 'user is logged in' do
      before :each do
        user_admin.confirm
        sign_in(user_admin)
        edit_profession
      end

      it 'should render proper template' do
        expect(edit_profession).to be_successful
        expect(edit_profession).to render_template('edit')
      end
    end

    context 'user is not admin and logged in' do
      before :each do
        user_not_admin.confirm
        sign_in(user_not_admin)
        edit_profession
      end

      it 'should be redirected to root path with alert message' do
        expect(response).to redirect_to :root
        expect(flash[:alert]).to be_present
      end
    end

    context 'user is not logged in' do
      it 'should be redirected to login panel with alert message' do
        expect(edit_profession).to redirect_to :new_user_session
        expect(flash[:alert]).to be_present
      end
    end
  end

end