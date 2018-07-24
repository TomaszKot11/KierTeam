require 'rails_helper'

RSpec.describe TagsController, type: :controller do

  describe 'index' do
    let!(:tag1) {create(:tag)}
    let!(:tag2) {create(:tag)}
    let!(:user_sud) { create(:user, is_admin:true) }
    subject(:get_index) { get :index }

    context 'user is logged in' do
      before :each do
        user_sud.confirm
        sign_in(user_sud)
        get_index
      end

      it 'should assing @tags variable' do
        expect(assigns(:tags)).to match_array([tag1, tag2])
      end

      it 'should render proper template' do
        expect(response).to be_successful
        expect(response).to render_template('index')
      end
    end

    context 'user is not logged in' do
      it 'unauthorized user should not see index' do
        get_index
        expect(response).to redirect_to :new_user_session
      end
    end
  end

  # describe '#create' do
  #   let(:tag) { create(:tag) }
  #   let!(:user_sud) { create(:user) }

  #   let(:valid_attributes) {  { tag: attributes_for(:tag) } }
  #   let(:invalid_attributes) {  { tag: attributes_for(:tag, name: nil) } }

  #   subject(:valid_post)  { post :create, params: valid_attributes }
  #   subject(:invalid_post) { post :create, params: invalid_attributes }

  #   context 'user is logged in' do
  #     before :each do
  #       user_sud.confirm
  #       sign_in(user_sud)
  #     end

  #     it 'should create tag with valid attributes and responses' do
  #       expect{valid_post}.to change { Tag.count }.by(1)
  #       valid_post
  #       expect(response).to redirect_to :tags
  #       expect(flash[:notice]).to be_present
  #     end

  #     it 'should not create tag with invalid attributes' do
  #       expect { invalid_post }.to change { Tag.count }.by(0)
  #     end

  #     it 'should re-render new form with invalid attributes' do
  #       invalid_post
  #       expect(flash[:alert]).to be_present
  #     end
  #   end

  #   context 'user is not logged in' do
  #     it 'should not be able to create' do
  #       expect { valid_post }.to change { Tag.count }.by(0)
  #       valid_post
  #       expect(response).to redirect_to :new_user_session
  #     end
  #   end
  # end

  # describe '#destroy' do

  #   let(:user_sud) { create(:user) }
  #   let!(:tag_sud) { create(:tag) }

  #   subject(:delete_tag) { delete :destroy, params: { id: tag_sud.id } }


  #     context 'logged in user' do

  #       before :each do
  #         user_sud.confirm
  #         sign_in(user_sud)
  #       end

  #       it 'should destroy proper tag' do
  #         expect { delete_tag }.to change { Tag.count }.by(-1)
  #       end

  #       it 'should redirect to root_path with alert after destroy' do
  #         delete_tag
  #         expect(response).to redirect_to(root_path)
  #         expect(flash[:alert]).to be_present
  #       end
  #     end

  #     it 'unauthorized should not destroy tag' do
  #       delete_tag
  #       redirect_to :sign_in
  #     end
  # end
end
