require 'rails_helper'

RSpec.describe ProblemsController, type: :controller do

    describe '#create' do
        let(:tag_sud) { create(:tag) }
        let!(:user_sud) { create(:user) }
        
        let(:valid_attributes) {  { tag: attributes_for(:tag) } }
        let(:invalid_attributes) {  { tag: attributes_for(tag, name: nil) } }

        subject(:valid_post)  { post :create,   params: valid_attributes }
        subject(:invalid_post) { post :create, params: invalid_attributes }

        before :each do
            user_sud.confirm
            #sign_in(user_sud)
        end

        it 'should create tag with valid attributes' do
            expect { valid_post }.to change { Tag.count }.by(1)
        end

        it 'should not create tag with invalid attributes' do
            expect { invalid_post }.to change { Tag.count }.by(0)
        end
        



    end
end
