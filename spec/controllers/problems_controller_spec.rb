require 'rails_helper'


RSpec.describe ProblemsController, type: :controller do 

    describe 'problems creating' do 

        let!(:user_sud) { create(:user) }
 
        context 'restrictions' do
            it 'not logged user should be restricted from creating new problems' do 
                get :new_logged_user
                expect(response).to redirect_to(new_user_session_path)
            end

            it 'logged in user should be able to create new post' do 
                # we confirm the user registration
                user_sud.confirm
                sign_in(user_sud)

                get :new_logged_user
                expect(response).to render_template('new_logged_user')       
            end
        end

        context 'problem creation for logged user' do
            let(:valid_attributes) {  { problem: attributes_for(:problem) } }
            let(:invalid_attributes) {  { problem: attributes_for(:problem, title: nil) } }

            subject(:valid_post)	{ post :create,	params:	valid_attributes } 
            subject(:invalid_post) { post :create, params: invalid_attributes }

            # User has to be confirmed and logged in each of this contex's tests
            before :each do
                user_sud.confirm
                sign_in(user_sud)
            end

            it 'should create problem with valid attributes' do
                expect { valid_post }.to change { Problem.count }.by(1)
            end

            it 'should not create problem with invalid attributes' do 
                expect { invalid_post }.to change { Problem.count }.by(0)
            end
            
            it 'should flash notice after creation with valid attributes' do 
                valid_post
                expect(flash[:notice]).to be_present
            end

            it 'should redirect to root_path creation with valid attributes' do 
                valid_post
                expect(response).to redirect_to(root_path)
            end

            it 'should render new_logged_user template when not valid post' do 
                invalid_post
                expect(response).to render_template('new_logged_user')
            end

        end
    end

    describe '#show' do 
        let(:problem_sud) { create(:problem) }

        it 'should redner proper template' do 
            get :show, params: { id: problem_sud.id }
            expect(response).to render_template('show')
        end
    end

    describe '#search_problems' do 
        # TODO: chenge this to create collection
        # and not to use fixed data
        let(:problem_included) { create(:problem, title: 'Hello') } 
        let(:problem_excluded) { create(:problem, title: 'Bye bye')}
        
        # TODO: try to extract get and paramatrize them ? 
        it 'should return proper data' do 
            get :search_problems, params: { lookup: 'Hello' }

            expect(assigns(:problems)).to match_array([ problem_included ])
        end
    
        it 'should not return not proper data' do 
            get :search_problems, params: { lookup: 'Hello' }

            expect(assigns(:problems)).not_to match_array([ problem_excluded ])
        end
      
        it 'when query blank should redirect to root with alert' do 
            get :search_problems, params: { lookup: nil }

            expect(flash[:alert]).to be_present
            expect(response).to redirect_to(root_path)
        end

    end
end