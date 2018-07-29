require 'rails_helper'

RSpec.describe ProfessionsController, type: :controller do

  let!(:user_not_admin) { create(:user,profession_id:nil) }
  let!(:user_admin) { create(:user, is_admin:true,profession_id:nil) }

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

      it 'should assing to @professions variable' do
        expect(assigns(:professions)).to match_array([profession1, profession2])
      end

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

  #------------------------------------------------------------------------

  describe '#create' do
    let(:valid_attributes) {  { profession: attributes_for(:profession) } }
    let(:invalid_attributes) {  { profession: attributes_for(:profession, name: nil) } }

    subject(:create_valid)  { post :create, format: :js, params: valid_attributes }
    subject(:create_invalid) { post :create, format: :js, params: invalid_attributes }
    subject(:create_default) { post :create }

    context 'user is admin and logged in' do
      before :each do
        user_admin.confirm
        sign_in(user_admin)
      end

      it 'should create profession with valid attributes' do
        expect { create_valid }.to change { Profession.count }.by(1)
      end

      it 'should not create profession with invalid attributes' do
        expect { create_invalid }.to change { Profession.count }.by(0)
      end
    end

    context 'user is not admin and logged in' do
      before :each do
        user_not_admin.confirm
        sign_in(user_not_admin)
        create_valid
      end

      it 'should be redirected to root path with alert message' do
        expect(response).to redirect_to :root
        expect(flash[:alert]).to be_present
      end

      it 'should not create a profession' do
        expect{create_default}.to change{ Profession.count }.by(0)
      end
    end

    context 'user is not logged in' do
      it 'should be redirected to login panel with alert message' do
        expect(create_default).to redirect_to :new_user_session
        expect(flash[:alert]).to be_present
      end

      it 'should not create a profession' do
        expect{create_default}.to change{ Profession.count }.by(0)
      end
    end
  end

  #------------------------------------------------------------------------

  describe '#destroy' do
    let!(:profession1) { create(:profession) }
    let!(:profession2) { create(:profession) }
    subject(:delete_valid) { delete :destroy, format: :js, params: { id: profession1.id } }
    subject(:delete_default) { delete :destroy, params: { id: profession1.id } }

    context 'used is admin and logged in' do
      before :each do
        user_admin.confirm
        sign_in(user_admin)
      end

      it 'should destroy profession with valid attributes' do
        expect { delete_valid }.to change { Profession.count }.by(-1)
      end
    end

    context 'used is not admin and logged in' do
      before :each do
        user_not_admin.confirm
        sign_in(user_not_admin)
        delete_default
      end

      it 'should be redirected to root path with alert message' do
        expect(response).to redirect_to :root
        expect(flash[:alert]).to be_present
      end

      it 'should not destroy profession' do
        expect{delete_default}.to change{ Profession.count }.by(0)
      end
    end

    context 'user is not logged in' do
      it 'should be redirected to login panel with alert message' do
        delete_default
        expect(response).to redirect_to :new_user_session
        expect(flash[:alert]).to be_present
      end

      it 'should not destroy profession' do
        expect{delete_default}.to change{ Profession.count }.by(0)
      end
    end
  end

  #------------------------------------------------------------------------

  describe '#update' do
    let!(:profession1) { create(:profession, name:'profession1_name') }
    let(:valid_attributes) {{ id: profession1.id, profession: { name:'profession1_name_changed' } }}
    let(:invalid_attributes) {{ id: profession1.id, format: :js, profession: { name:'' } }}
    subject(:update_profession_valid) { patch :update, params: valid_attributes }
    subject(:update_profession_invalid) { patch :update, params: invalid_attributes }

    context 'user is admin and logged in' do
      before :each do
        user_admin.confirm
        sign_in(user_admin)
      end

      it 'should update profession with valid attributes, redirect to index with notice message' do
        update_profession_valid
        expect(response).to redirect_to(professions_path)
        expect(flash[:notice]).to be_present
        expect(profession1.reload.name).to eq('profession1_name_changed')
      end

      it 'should not update profession with invalid attributes' do
        update_profession_invalid
        expect(profession1.reload.name).to eq('profession1_name')
      end
    end

    context 'user is not admin and logged in' do
      before :each do
        user_not_admin.confirm
        sign_in(user_not_admin)
        update_profession_valid
      end

      it 'should not update profession' do
        expect(profession1.reload.name).to eq('profession1_name')
      end

      it 'should be redirected to root path with alert message' do
        expect(response).to redirect_to :root
        expect(flash[:alert]).to be_present
      end
    end

    context 'user is not logged in' do
      it 'should not update profession' do
        update_profession_valid
        expect(profession1.reload.name).to eq('profession1_name')
      end

      it 'unauthorized should not update profession' do
        update_profession_valid
        expect(response).to redirect_to :new_user_session
      end
    end
  end
end