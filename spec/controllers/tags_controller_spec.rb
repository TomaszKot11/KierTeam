require 'rails_helper'

RSpec.describe TagsController, type: :controller do

  let!(:user_not_admin) { create(:user) }
  let!(:user_admin) { create(:user, is_admin:true) }

  describe 'index' do
    let!(:tag1) {create(:tag)}
    let!(:tag2) {create(:tag)}
    subject(:get_index) { get :index }

    context 'user is admin and logged in' do
      before :each do
        user_admin.confirm
        sign_in(user_admin)
        get_index
      end

      it 'should assing to @tags variable' do
        expect(assigns(:tags)).to match_array([tag1, tag2])
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
    let!(:tag1) { create(:tag, name:'tag1_name') }
    let!(:valid_attributes) { { id: tag1.id, tag: {name: 'tag1_name'}}}
    subject(:edit_tag) { get :edit, params: valid_attributes  }

    context 'used is logged in' do
      before :each do
        user_admin.confirm
        sign_in(user_admin)
        edit_tag
      end

      it 'should render proper template' do
        expect(edit_tag).to be_successful
        expect(edit_tag).to render_template('edit')
      end
    end

    context 'user is not admin and logged in' do
      before :each do
        user_not_admin.confirm
        sign_in(user_not_admin)
        edit_tag
      end

      it 'should be redirected to root path with alert message' do
        expect(response).to redirect_to :root
        expect(flash[:alert]).to be_present
      end
    end

    context 'user is not logged in' do
      it 'should be redirected to login panel with alert message' do
        expect(edit_tag).to redirect_to :new_user_session
        expect(flash[:alert]).to be_present
      end
    end
  end

  # ------------------------------------------------------------------------

  describe '#create' do
    let(:valid_attributes) {  { tag: attributes_for(:tag) } }
    let(:invalid_attributes) {  { tag: attributes_for(:tag, name: nil) } }

    subject(:create_valid)  { post :create, format: :js, params: valid_attributes }
    subject(:create_invalid) { post :create, format: :js, params: invalid_attributes }
    subject(:create_default) { post :create }

    context 'user is admin and logged in' do
      before :each do
        user_admin.confirm
        sign_in(user_admin)
      end

      it 'should create tag with valid attributes' do
        expect { create_valid }.to change { Tag.count }.by(1)
      end

      it 'should not create tag with invalid attributes' do
        expect { create_invalid }.to change { Tag.count }.by(0)
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

      it 'should not create a tag' do
        expect{create_default}.to change{ Tag.count }.by(0)
      end
    end

    context 'user is not logged in' do
      it 'should be redirected to login panel with alert message' do
        expect(create_default).to redirect_to :new_user_session
        expect(flash[:alert]).to be_present
      end

      it 'should not create a tag' do
        expect{create_default}.to change{ Tag.count }.by(0)
      end
    end
  end

  # ------------------------------------------------------------------------

  describe '#destroy' do
    let!(:tag1) { create(:tag) }
    let!(:tag2) { create(:tag) }
    subject(:delete_valid) { delete :destroy, format: :js, params: { id: tag1.id } }
    subject(:delete_default) { delete :destroy, params: { id: tag1.id } }

    context 'used is admin and logged in' do
      before :each do
        user_admin.confirm
        sign_in(user_admin)
      end

      it 'should destroy tag with valid attributes' do
        expect { delete_valid }.to change { Tag.count }.by(-1)
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

      it 'should not destroy tag' do
        expect{delete_default}.to change{ Tag.count }.by(0)
      end
    end

    context 'user is not logged in' do
      it 'should be redirected to login panel with alert message' do
        delete_default
        expect(response).to redirect_to :new_user_session
        expect(flash[:alert]).to be_present
      end

      it 'should not destroy tag' do
        expect{delete_default}.to change{ Tag.count }.by(0)
      end
    end
  end

  # ------------------------------------------------------------------------

  describe '#update' do
    let!(:tag1) { create(:tag, name:'tag1_name') }
    let(:valid_attributes) {{ id: tag1.id, tag: { name:'tag1_name_changed' } }}
    let(:invalid_attributes) {{ id: tag1.id, tag: { name:'' } }}
    subject(:update_tag_valid) { patch :update, params: valid_attributes }
    subject(:update_tag_invalid) { patch :update, params: invalid_attributes }

    context 'user is admin and logged in' do
      before :each do
        user_admin.confirm
        sign_in(user_admin)
      end

      it 'should update tag with valid attributes, redirect to index with notice message' do
        update_tag_valid
        expect(response).to redirect_to(tags_path)
        expect(flash[:notice]).to be_present
        expect(tag1.reload.name).to eq('tag1_name_changed')
      end

      it 'should not update tag with invalid attributes, redirect to index with notice message' do
        update_tag_invalid
        expect(response).to redirect_to(tags_path)
        expect(flash[:alert]).to be_present
        expect(tag1.reload.name).to eq('tag1_name')
      end
    end

    context 'user is not admin and logged in' do
      before :each do
        user_not_admin.confirm
        sign_in(user_not_admin)
        update_tag_valid
      end

      it 'should not update tag' do
        expect(tag1.reload.name).to eq('tag1_name')
      end

      it 'should be redirected to root path with alert message' do
        expect(response).to redirect_to :root
        expect(flash[:alert]).to be_present
      end
    end

    context 'user is not logged in' do
      it 'should not update tag' do
        update_tag_valid
        expect(tag1.reload.name).to eq('tag1_name')
      end

      it 'unauthorized should not destroy tag' do
        update_tag_valid
        expect(response).to redirect_to :new_user_session
      end
    end
  end
end
