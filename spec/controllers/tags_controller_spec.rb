require 'rails_helper'

RSpec.describe TagsController, type: :controller do

  describe '#create' do
    let(:tag_sud) { create(:tag) }
    let!(:user_sud) { create(:user) }

    let(:valid_attributes) {  { tag: attributes_for(:tag) } }
    let(:invalid_attributes) {  { tag: attributes_for(:tag, name: nil) } }

    subject(:valid_post)  { post :create, params: valid_attributes }
    subject(:invalid_post) { post :create, params: invalid_attributes }

    context 'logged in user valid and invalid tag creation' do

      before :each do
        user_sud.confirm
        sign_in(user_sud)
      end

      it 'should create tag with valid attributes' do
        expect { valid_post }.to change { Tag.count }.by(1)
      end

      it 'should redirect_to root_path with notice after valid tag creation' do
        valid_post
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to be_present
      end

      it 'should not create tag with invalid attributes' do
        expect { invalid_post }.to change { Tag.count }.by(0)
      end

      it 'should re-render new form with invalid attributes' do
        invalid_post
        expect(response).to render_template('new')
      end
    end

    it 'not logged in user should not create tag' do
      expect { valid_post }.to change { Tag.count }.by(0)
    end

    end

    describe '#new' do

    let!(:user_sud) { create(:user) }

    subject(:get_new)  { get :new }

    context 'logged in user new' do

        before :each do
          user_sud.confirm
          sign_in(user_sud)
          get_new
        end

        it 'should render new template' do
          expect(response).to render_template('new')
        end

        it 'should assign @tag variable' do
          expect(assigns(:tag)).not_to be_nil
        end
      end

      it 'unauthorized user should be redirected to log in' do
        get_new
        redirect_to :sign_in
      end

    end

  describe '#destroy' do

    let(:user_sud) { create(:user) }
    let!(:tag_sud) { create(:tag) }

    subject(:delete_tag) { delete :destroy, params: { id: tag_sud.id } }


      context 'logged in user' do

        before :each do
          user_sud.confirm
          sign_in(user_sud)
        end

        it 'should destroy proper tag' do
          expect { delete_tag }.to change { Tag.count }.by(-1)
        end

        it 'should redirect to root_path with alert after destroy' do
          delete_tag
          expect(response).to redirect_to(root_path)
          expect(flash[:alert]).to be_present
        end
      end

      it 'unauthorized should not destroy tag' do
        delete_tag
        redirect_to :sign_in
      end

  end

  describe 'index' do
    let(:user_sud) { create(:user) }
    subject(:get_index) { get :index }

    context 'logged in' do
      before :each do
        user_sud.confirm
        sign_in(user_sud)
        get_index
      end

      it 'should assing @tags variable' do
        expect(assigns(:tags)).not_to be_nil
      end

      it 'should render proper template' do
        expect(response).to render_template('index')
      end

    end

    it 'unauthorized user should not see index' do
      get_index
      redirect_to :sign_in
    end
  
  end
end
