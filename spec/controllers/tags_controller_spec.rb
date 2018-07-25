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
end
